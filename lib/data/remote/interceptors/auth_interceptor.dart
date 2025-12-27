// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:d3_wallet/data/repositories/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorageRepository _secureStorage = Get.find<SecureStorageRepository>();
  Future<bool>? _refreshFuture;

  AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.get(StorageKeys.accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final requestToken = err.requestOptions.headers['Authorization']?.toString().replaceAll(
        'Bearer ',
        '',
      );
      final currentToken = await _secureStorage.get(StorageKeys.accessTokenKey);

      // 1. Staleness Check: If token in storage is different from the one that failed,
      // it means someone else already refreshed it.
      if (requestToken != currentToken && currentToken != null) {
        return _retryRequest(err.requestOptions, currentToken, handler);
      }

      // 2. Synchronized Refresh
      final refreshToken = await _secureStorage.get(StorageKeys.refreshTokenKey);
      if (refreshToken != null) {
        _refreshFuture ??= _performRefresh(refreshToken);

        try {
          final success = await _refreshFuture;
          if (success == true) {
            final newToken = await _secureStorage.get(StorageKeys.accessTokenKey);
            if (newToken != null) {
              return _retryRequest(err.requestOptions, newToken, handler);
            }
          }
        } catch (e) {
          // Handle refresh token failure (e.g., logout user)
          // Get.find<AuthService>().logout();
        }
      }
    }
    return handler.next(err);
  }

  Future<void> _retryRequest(
    RequestOptions options,
    String token,
    ErrorInterceptorHandler handler,
  ) async {
    options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await _dio.fetch(options);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  Future<bool> _performRefresh(String refreshToken) async {
    try {
      final success = await _refreshToken(refreshToken);
      return success;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<bool> _refreshToken(String refreshToken) async {
    try {
      // Placeholder: Implement actual refresh token API call
      // final response = await _dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
      // if (response.statusCode == 200) {
      //   final newAccessToken = response.data['access_token'];
      //   final newRefreshToken = response.data['refresh_token'];
      //   await _secureStorage.set(StorageKeys.accessTokenKey, newAccessToken);
      //   await _secureStorage.set(StorageKeys.refreshTokenKey, newRefreshToken);
      //   return true;
      // }
      return false;
    } catch (e) {
      return false;
    }
  }
}
