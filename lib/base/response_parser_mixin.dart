// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:flutter/material.dart';

/// A mixin that provides helper methods to parse data from [BaseResponseObject]
/// in views that use networking controllers.
///
/// Usage:
/// ```dart
/// class MyView extends BaseNetworkingView<MyController> with ResponseParserMixin {
///   @override
///   Widget buildBody(BuildContext context, dynamic state) {
///     final data = parseResponse<MyDataType>(state);
///     if (data == null) return buildEmpty(context);
///     return MyWidget(data: data);
///   }
/// }
/// ```
mixin ResponseParserMixin {
  /// Parses and extracts the `data` field from a [BaseResponseObject].
  ///
  /// Returns `null` if:
  /// - [state] is null
  /// - [state] is not a [BaseResponseObject]
  /// - The response's `data` field is null
  /// - The data cannot be cast to type [D]
  D? parseResponse<D>(dynamic state) {
    if (state == null) return null;
    if (state is BaseResponseObject<D>) {
      return state.data;
    }
    if (state is BaseResponseObject) {
      return state.data as D?;
    }
    return null;
  }

  /// Extracts the message from a [BaseResponseObject].
  ///
  /// Returns `null` if [state] is not a [BaseResponseObject].
  String? parseMessage(dynamic state) {
    if (state is BaseResponseObject) {
      return state.message;
    }
    return null;
  }

  /// Extracts the code from a [BaseResponseObject].
  ///
  /// Returns `null` if [state] is not a [BaseResponseObject].
  String? parseCode(dynamic state) {
    if (state is BaseResponseObject) {
      return state.code;
    }
    return null;
  }

  /// Returns `true` if the response was successful.
  ///
  /// Returns `false` if [state] is not a [BaseResponseObject].
  bool isResponseSuccess(dynamic state) {
    if (state is BaseResponseObject) {
      return state.success == true || state.isSuccess();
    }
    return false;
  }

  /// Widget builder helper that handles null data case.
  ///
  /// If parsed data is null, returns `onNull` widget.
  /// Otherwise, calls `builder` with the parsed data.
  Widget buildWithData<D>({
    required dynamic state,
    required Widget Function(D data) builder,
    Widget onNull = const SizedBox.shrink(),
  }) {
    final data = parseResponse<D>(state);
    if (data == null) return onNull;
    return builder(data);
  }
}
