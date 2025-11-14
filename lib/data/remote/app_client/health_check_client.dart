// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/health_check_response_object/health_check_response_object.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'health_check_client.g.dart';

@RestApi()
abstract class HealthCheckClient {
  factory HealthCheckClient(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) =
      _HealthCheckClient;

  @GET("")
  Future<BaseResponseObject<HealthCheckResponseObject?>?> healthz();
}
