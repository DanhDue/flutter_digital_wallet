// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/base_url_response_object/base_url_response_object.dart';
import 'package:d3_wallet/data/bean/response/health_check_response_object/health_check_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';

abstract class ServiceCheckingRepository {
  Future<Result<BaseResponseObject<HealthCheckResponseObject?>?, ApiError>> healthz();
  Future<Result<BaseResponseObject<BaseUrlResponseObject?>?, ApiError>> retrieveBaseUrl();
  Future<void> updateBaseUrl(String newBaseUrl);
}
