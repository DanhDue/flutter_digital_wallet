// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'health_check_response_object.freezed.dart';
part 'health_check_response_object.g.dart';

@freezed
abstract class HealthCheckResponseObject with _$HealthCheckResponseObject {
  const factory HealthCheckResponseObject({
    @JsonKey(name: 'service') String? service,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'version') String? version,
    @JsonKey(name: 'timestamp') int? timestamp,
    @JsonKey(name: 'account_owner') String? accountOwner,
  }) = _HealthCheckResponseObject;

  factory HealthCheckResponseObject.fromJson(Map<String, Object?> json) =>
      _$HealthCheckResponseObjectFromJson(json);
}
