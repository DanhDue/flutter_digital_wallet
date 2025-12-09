// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/health_check_response_object/health_check_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/app_client/health_check_client.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/service_checking_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ServiceCheckingRepositoryImpl extends ServiceCheckingRepository with SafeCallApiMixin {
  final healthzClient = Get.find<HealthCheckClient>();

  @override
  Future<Result<BaseResponseObject<HealthCheckResponseObject?>?, ApiError>> healthz() =>
      safeApiCall(() => healthzClient.healthz());
}
