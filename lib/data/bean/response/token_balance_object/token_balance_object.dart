// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'token_balance_object.freezed.dart';
part 'token_balance_object.g.dart';

@freezed
abstract class TokenBalanceObject with _$TokenBalanceObject {
  const factory TokenBalanceObject({
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: 'changes') double? changes,
    @JsonKey(name: 'post_balance') String? postBalance,
  }) = _TokenBalanceObject;

  factory TokenBalanceObject.fromJson(Map<String, Object?> json) =>
      _$TokenBalanceObjectFromJson(json);
}
