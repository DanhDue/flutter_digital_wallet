// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/environment_configurations.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:d3_wallet/data/remote/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:io';

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

  DioFactory();

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
    dioInstance.interceptors.add(AuthInterceptor(dioInstance));

    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(ApiError.fromDioError(e));
        },
      ),
    );

    // SSL Pinning implementation
    if (!kIsWeb) {
      (dioInstance.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient(context: SecurityContext(withTrustedRoots: true));
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          // In production, you should validate the certificate fingerprint
          // This is a placeholder for SSL Pinning logic
          // final allowedFingerprints = ["SHA-256-FINGERPRINT-HERE"];
          // return allowedFingerprints.contains(sha256.convert(cert.der).toString());
          return false; // Reject by default if pinning fails
        };
        return client;
      };
    }

    return dioInstance;
  }
}
