// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/health_check_response_object/health_check_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/result.dart';

abstract class AppConfigsRepository with SafeCallApiMixin {
  Future saveLocalPassword(String? password);

  Future saveAppConfigurations(AppConfigurations? appConfigurations);

  Future<AppConfigurations?> retrieveAppConfigurations();

  Future clearAppData();

  Future<Result<BaseResponseObject<HealthCheckResponseObject?>?, ApiError>> healthz();
}
