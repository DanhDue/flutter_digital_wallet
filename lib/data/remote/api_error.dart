// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/remote/http_response_code.dart';
import 'package:dio/dio.dart';

class ApiError extends DioException {
  ApiExceptionType? errorType;
  BaseResponseObject? data;

  ApiError({
    required super.requestOptions,
    super.response,
    super.type,
    String super.message = 'Unknown error occurred',
    Error? super.error,
    this.errorType,
    this.data,
  });

  /// Creates an ApiError from a BaseResponseObject error message.
  /// Used when the API returns success=false in the response body.
  factory ApiError.fromBaseResponseError(String message) {
    return ApiError(
      requestOptions: RequestOptions(path: ''),
      errorType: ApiExceptionType.badResponse,
      message: message,
    );
  }

  factory ApiError.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          requestOptions: dioError.requestOptions,
          errorType: ApiExceptionType.connectionTimeout,
          message: 'Connection timeout. Please try again.',
        );
      case DioExceptionType.receiveTimeout:
        return ApiError(
          requestOptions: dioError.requestOptions,
          errorType: ApiExceptionType.receiveTimeout,
          message: 'Server is taking too long to respond. Please try again.',
        );
      case DioExceptionType.sendTimeout:
        return ApiError(
          requestOptions: dioError.requestOptions,
          errorType: ApiExceptionType.sendTimeout,
          message: 'Failed to send request. Please try again.',
        );
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        String message;

        if (statusCode == HttpResponseCode.HTTP_UNAUTHORIZED) {
          message = 'Unauthorized. Please login again.';
        } else if (statusCode == HttpResponseCode.HTTP_FORBIDDEN) {
          message = 'You do not have permission to access this resource.';
        } else if (statusCode == HttpResponseCode.HTTP_NOT_FOUND) {
          message = 'The requested resource was not found.';
        } else if (statusCode == HttpResponseCode.HTTP_INTERNAL_ERROR) {
          message = 'Server error. Please try again later.';
        } else {
          message = dioError.response?.data?['message'] ?? 'An error occurred.';
        }

        return ApiError(
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          errorType: ApiExceptionType.badResponse,
          data: BaseResponseObject<dynamic>.fromJson(dioError.response?.data, (json) => json),
          message: message,
        );
      case DioExceptionType.cancel:
        return ApiError(
          requestOptions: dioError.requestOptions,
          errorType: ApiExceptionType.cancel,
          message: 'Request was cancelled',
        );
      case DioExceptionType.connectionError:
        return ApiError(
          requestOptions: dioError.requestOptions,
          errorType: ApiExceptionType.connectionError,
          message: 'No internet connection. Please check your connection and try again.',
        );
      case DioExceptionType.unknown:
      default:
        return ApiError(
          requestOptions: dioError.requestOptions,
          errorType: ApiExceptionType.unknown,
          message: 'An unexpected error occurred.',
          error: dioError.error is Error ? dioError.error as Error : null,
        );
    }
  }

  @override
  String toString() {
    return message ?? "";
  }
}

enum ApiExceptionType {
  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  /// It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// The [ApiError] was caused by an incorrect status code as configured by
  /// [ValidateStatus].
  badResponse,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  /// no internet connection
  noInternetConnection,

  /// JSON parsing error.
  jsonParseException,

  /// Default error type, Some other [Error]. In this case, you can use the
  /// [DioException.error] if it is not null.
  unknown,
}
