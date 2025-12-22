// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'coin_market_platform_object.freezed.dart';
part 'coin_market_platform_object.g.dart';

@freezed
abstract class CoinMarketPlatformObject with _$CoinMarketPlatformObject {
  const factory CoinMarketPlatformObject({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'token_address') String? tokenAddress,
  }) = _CoinMarketPlatformObject;

  factory CoinMarketPlatformObject.fromJson(Map<String, Object?> json) =>
      _$CoinMarketPlatformObjectFromJson(json);
}
