// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get.dart';

/// Result of parsing a response, can be either success with data or error with message.
sealed class _ParsedResponse {}

class _ParsedSuccess extends _ParsedResponse {
  final dynamic data;
  _ParsedSuccess(this.data);
}

class _ParsedError extends _ParsedResponse {
  final String message;
  _ParsedError(this.message);
}

enum LoadingType { full, overlay, none }

/// A mixin that provides networking capabilities to any controller
/// that uses [StateMixin].
///
/// This mixin automatically parses [BaseResponseObject] and extracts
/// the `data` field, so views receive the actual data directly.
/// If [BaseResponseObject.success] is false, it triggers the error state.
///
/// Usage:
/// ```dart
/// class MyController extends BaseController<MyState> with BaseNetworkingMixin<MyState> {
///   void fetchData() {
///     callApi(
///       myRepository.getData(),
///       onSuccess: (data) => print('Success: $data'),
///       onError: (error) => print('Error: $error'),
///     );
///   }
/// }
/// ```
mixin NetworkingMixin<T> on BaseController<T> {
  /// Parses [BaseResponseObject] and extracts the `data` field.
  /// If [BaseResponseObject.success] is false, returns an error result.
  /// If the input is not a [BaseResponseObject], returns it as-is.
  _ParsedResponse _parseResponseData(dynamic data) {
    if (data is BaseResponseObject) {
      if (data.success == false || !data.isSuccess()) {
        return _ParsedError(data.message ?? 'Unknown error');
      }
      return _ParsedSuccess(data.data);
    }
    return _ParsedSuccess(data);
  }

  /// Executes an API call and handles loading, success, and error states automatically.
  ///
  /// [apiCall] - The Future that performs the API request
  /// [onSuccess] - Callback invoked with the data when the API call succeeds
  /// [onError] - Optional callback invoked with the error when the API call fails
  /// [loadingType] - Type of loading indicator to show (default: LoadingType.full)
  ///
  /// Note: If the response is a [BaseResponseObject], the `data` field is
  /// automatically extracted and passed to the state. If [BaseResponseObject.success]
  /// is false, the error state is triggered with the response message.
  Future<void> callApi<D>(
    Future<Result<D, ApiError>> apiCall, {
    required void Function(D data) onSuccess,
    void Function(ApiError error)? onError,
    LoadingType loadingType = LoadingType.full,
  }) async {
    if (loadingType == LoadingType.full) {
      change(state, status: RxStatus.loading());
    } else if (loadingType == LoadingType.overlay) {
      isLoading.value = true;
    }

    final result = await apiCall;

    if (loadingType == LoadingType.overlay) {
      isLoading.value = false;
    }

    switch (result) {
      case Success(data: final data):
        final parsedResponse = _parseResponseData(data);
        switch (parsedResponse) {
          case _ParsedSuccess(data: final parsedData):
            onSuccess(data);
            change(parsedData as T?, status: RxStatus.success());
          case _ParsedError(message: final message):
            if (onError != null) {
              onError(ApiError.fromBaseResponseError(message));
            }
            change(state, status: RxStatus.error(message));
        }
      case Failure(error: final error):
        if (onError != null) {
          onError(error);
        }
        change(state, status: RxStatus.error(error.message));
    }
  }

  /// Executes multiple API calls in parallel and handles states.
  ///
  /// [apiCalls] - List of Futures that perform API requests
  /// [onAllSuccess] - Callback invoked when all API calls succeed
  /// [onAnyError] - Optional callback invoked if any API call fails
  ///
  /// Note: If the responses are [BaseResponseObject]s, the `data` fields are
  /// automatically extracted and passed to the state as a list.
  Future<void> callMultipleApis<D>(
    List<Future<Result<D, ApiError>>> apiCalls, {
    required void Function(List<D> data) onAllSuccess,
    void Function(ApiError error)? onAnyError,
    LoadingType loadingType = LoadingType.full,
  }) async {
    if (loadingType == LoadingType.full) {
      change(state, status: RxStatus.loading());
    } else if (loadingType == LoadingType.overlay) {
      isLoading.value = true;
    }

    final results = await Future.wait(apiCalls);
    final successData = <D>[];
    ApiError? firstError;

    for (final result in results) {
      switch (result) {
        case Success(data: final data):
          successData.add(data);
        case Failure(error: final error):
          firstError ??= error;
      }
    }

    if (loadingType == LoadingType.overlay) {
      isLoading.value = false;
    }

    if (firstError != null) {
      if (onAnyError != null) {
        onAnyError(firstError);
      }
      change(state, status: RxStatus.error(firstError.message));
    } else {
      onAllSuccess(successData);
      // Parse each item if it's a BaseResponseObject
      final parsedData = successData.map(_parseResponseData).toList();
      change(parsedData as T?, status: RxStatus.success());
    }
  }
}
