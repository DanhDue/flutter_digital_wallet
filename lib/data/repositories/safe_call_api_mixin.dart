// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

// 1. check internet connection between call an api.
// 2. handle api call exceptions.
mixin SafeCallApiMixin {
  Future<Result<R, ApiError>> safeApiCall<R>(Function call, {Map<String, dynamic>? params}) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return Result.failure(
          ApiError(
            requestOptions: RequestOptions(data: {"function": call.toString()}),
            errorType: ApiExceptionType.connectionError,
            message: 'No internet connection. Please check your connection and try again.',
          ),
        );
      } else {
        var result = params == null ? await call() : await call(params);
        return Result.success(result);
      }
    } on TypeError catch (e) {
      final error = ApiError(
        requestOptions: RequestOptions(data: {"function": call.toString()}),
        errorType: ApiExceptionType.jsonParseException,
        message: e.toString() + e.stackTrace.toString(),
        error: e,
      );
      Fimber.d("ApiError: ${error.toString()}");
      Get.find<Talker>().error("API Error: ${error.toString()}");
      return Result.failure(error);
    } on ApiError catch (e) {
      return Result.failure(e);
    } catch (e) {
      final error = ApiError(
        requestOptions: RequestOptions(data: {"function": call.toString()}),
        errorType: ApiExceptionType.unknown,
        message: 'An unexpected error occurred.',
        error: e is Error ? e : null,
      );
      Fimber.d("ApiError: ${error.toString()}");
      return Result.failure(error);
    }
  }
}
