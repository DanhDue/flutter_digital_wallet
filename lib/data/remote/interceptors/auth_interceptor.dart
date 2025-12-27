// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart' hide Response;

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final AppConfigsRepository _appConfigsRepo = Get.find<AppConfigsRepository>();

  AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final appConfigs = await _appConfigsRepo.retrieveAppConfigurations();
    final token = appConfigs?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Fimber.d(
      'AuthInterceptor onError: ${err.error?.runtimeType.toString()} - ${err.error?.toString()}',
    );
    if (err.response?.statusCode == 401) {
      final requestToken = err.requestOptions.headers['Authorization']?.toString().replaceAll(
        'Bearer ',
        '',
      );

      final appConfigs = await _appConfigsRepo.retrieveAppConfigurations();
      final currentToken = appConfigs?.accessToken;

      // 1. Staleness Check
      if (requestToken != currentToken && currentToken != null) {
        return _retryRequest(err.requestOptions, currentToken, handler);
      }

      // 2. Refresh Token
      final refreshToken = appConfigs?.refreshToken;
      if (refreshToken != null) {
        try {
          final success = await _refreshToken(refreshToken);
          if (success == true) {
            final updatedConfigs = await _appConfigsRepo.retrieveAppConfigurations();
            final newToken = updatedConfigs?.accessToken;
            if (newToken != null) {
              return _retryRequest(err.requestOptions, newToken, handler);
            }
          }
        } catch (e) {
          Fimber.d('Token refresh failed: ${e.toString()}');
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

  Future<bool> _refreshToken(String refreshToken) async {
    try {
      // Placeholder: Implement actual refresh token API call
      // final response = await _dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
      // if (response.statusCode == 200) {
      //   final newAccessToken = response.data['access_token'];
      //   final newRefreshToken = response.data['refresh_token'];
      //
      //   final currentConfigs = await _appConfigsRepo.retrieveAppConfigurations() ?? const AppConfigurations();
      //   await _appConfigsRepo.saveAppConfigurations(currentConfigs.copyWith(
      //     accessToken: newAccessToken,
      //     refreshToken: newRefreshToken,
      //   ));
      //   return true;
      // }
      return false;
    } catch (e) {
      return false;
    }
  }
}
