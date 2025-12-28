// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/environment_configurations.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:native_security/native_security.dart';
import 'package:d3_wallet/data/remote/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:fimber/fimber.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
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

    // True SSL Pinning implementation
    if (!kIsWeb) {
      (dioInstance.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        // withTrustedRoots: false ensures that NO system-trusted CAs are used.
        // This forces badCertificateCallback to be called for ALL certificates,
        // allowing us to manually validate even "valid" CA-signed certificates.
        final client = HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          // In production, update this list with the SHA-256 fingerprints of your server's certificate.
          // Note: This implementation uses Certificate Pinning (hashing the entire DER certificate).

          // To get the correct fingerprint:
          // Build-time fingerprints from --dart-define=SSL_FINGERPRINTS="pin1,pin2"
          final envFingerprints = EnvironmentConfig.SSL_FINGERPRINTS
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

          Fimber.d('Env fingerprints: $envFingerprints');

          // Hardened fingerprints from C++ via FFI package
          List<String> hardenedFingerprints = [];
          try {
            hardenedFingerprints = NativeSecurity.getAllowedFingerprints();
            Fimber.d('Hardened fingerprints loaded: $hardenedFingerprints');
          } catch (e) {
            Fimber.e('Failed to load hardened fingerprints via FFI: $e');
            // Fail-safe: continue with empty list or however you prefer.
            // Since we have envFingerprints, the app will still function.
          }

          // Merge both lists (prioritizing hardened ones)
          final allowedFingerprints = {...hardenedFingerprints, ...envFingerprints}.toList();

          // Calculate the SHA-256 digest of the DER-encoded certificate
          final hash = sha256.convert(cert.der);

          // Encode to Base64 to match standard fingerprint formats
          final fingerprint = base64.encode(hash.bytes);

          Fimber.d('Handshake fingerprint: $fingerprint');

          final isValid = allowedFingerprints.contains(fingerprint);
          if (!isValid) {
            Fimber.w('SSL Pinning failed for $host. Fingerprint mismatch.');
          }
          return isValid;
        };
        return client;
      };
    }

    return dioInstance;
  }
}
