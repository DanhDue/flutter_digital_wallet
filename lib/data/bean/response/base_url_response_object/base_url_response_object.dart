// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/utils/json_converter/jiffy_long_json_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jiffy/jiffy.dart';

part 'base_url_response_object.freezed.dart';
part 'base_url_response_object.g.dart';

@freezed
abstract class BaseUrlResponseObject with _$BaseUrlResponseObject {
  const factory BaseUrlResponseObject({
    @JsonKey(name: 'app_id') String? appId,
    @JsonKey(name: 'base_url') String? baseUrl,
    @JsonKey(name: 'updated_at') @JiffyLongJsonConverter() Jiffy? updatedAt,
  }) = _BaseUrlResponseObject;

  factory BaseUrlResponseObject.fromJson(Map<String, Object?> json) =>
      _$BaseUrlResponseObjectFromJson(json);
}
