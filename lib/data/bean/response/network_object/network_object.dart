// Copyright (c) 2025, one of the UniCloud projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_object.freezed.dart';
part 'network_object.g.dart';

@freezed
abstract class NetworkObject with _$NetworkObject {
  const factory NetworkObject({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'name') String? name,
  }) = _NetworkObject;

  factory NetworkObject.fromJson(Map<String, Object?> json) => _$NetworkObjectFromJson(json);
}
