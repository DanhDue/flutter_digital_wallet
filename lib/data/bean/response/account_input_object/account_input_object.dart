// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'account_input_object.freezed.dart';
part 'account_input_object.g.dart';

@freezed
abstract class AccountInputObject with _$AccountInputObject {
  const factory AccountInputObject({
    @JsonKey(name: 'is_payer') bool? isPayer,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'changes') int? changes,
    @JsonKey(name: 'post_balance') double? postBalance,
    @JsonKey(name: 'details') List<String>? details,
  }) = _AccountInputObject;

  factory AccountInputObject.fromJson(Map<String, Object?> json) =>
      _$AccountInputObjectFromJson(json);
}
