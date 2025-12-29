// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/base_url_response_object/base_url_response_object.dart';
import 'package:d3_wallet/data/bean/response/health_check_response_object/health_check_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/app_client/health_check_client.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/service_checking_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class ServiceCheckingRepositoryImpl extends ServiceCheckingRepository with SafeCallApiMixin {
  final healthzClient = Get.find<HealthCheckClient>();
  final _appConfigsRepo = Get.find<AppConfigsRepository>();
  final _dio = Get.find<Dio>();

  @override
  Future<Result<BaseResponseObject<HealthCheckResponseObject?>?, ApiError>> healthz() =>
      safeApiCall(() => healthzClient.healthz());

  @override
  Future<Result<BaseResponseObject<BaseUrlResponseObject?>?, ApiError>> retrieveBaseUrl() =>
      safeApiCall(() => healthzClient.getBaseUrl());

  @override
  Future<void> updateBaseUrl(String newBaseUrl) async {
    Fimber.d("Updating base URL to: $newBaseUrl");

    // Update Dio instance
    _dio.options.baseUrl = newBaseUrl;

    // Update persistence
    final currentConfigs = await _appConfigsRepo.retrieveAppConfigurations();
    if (currentConfigs != null) {
      await _appConfigsRepo.saveAppConfigurations(currentConfigs.copyWith(baseUrl: newBaseUrl));
    }
  }
}
