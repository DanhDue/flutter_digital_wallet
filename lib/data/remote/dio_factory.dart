// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/environment_configurations.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
class DioFactory {
  Duration _connectTimeout = const Duration(milliseconds: AppUri.connectionTimeout);
  Duration _receiveTimeout = const Duration(milliseconds: AppUri.receiveTimeout);

  DioFactory withConnectTimeout(Duration timeout) {
    _connectTimeout = timeout;
    return this;
  }

  DioFactory withReceiveTimeout(Duration timeout) {
    _receiveTimeout = timeout;
    return this;
  }

  Dio? _dio;

  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  DioFactory._internal();

  Dio _createDio() {
    final dioInstance = Dio(
      BaseOptions(
        baseUrl: EnvironmentConfig.BASE_URL,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (!kReleaseMode || EnvironmentConfig.USE_TALKER) {
      dioInstance.interceptors.add(
        TalkerDioLogger(
          talker: Get.find<Talker>(),
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: false,
            printRequestData: true,
            printResponseData: true,
          ),
        ),
      );
    }
    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add bearer token if user is logged in
          // final token = Get.find<StorageService>().getToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(ApiError.fromDioError(e));
        },
      ),
    );
    return dioInstance;
  }

  static final DioFactory _singleton = DioFactory._internal();
  factory DioFactory() {
    return _singleton;
  }
}
