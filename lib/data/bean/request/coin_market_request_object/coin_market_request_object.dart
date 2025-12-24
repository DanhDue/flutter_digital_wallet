// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_market_request_object.freezed.dart';
part 'coin_market_request_object.g.dart';

@freezed
abstract class CoinMarketRequestObject with _$CoinMarketRequestObject {
  @JsonSerializable(includeIfNull: false)
  const factory CoinMarketRequestObject({
    @JsonKey(name: 'start') int? start,
    @JsonKey(name: 'limit') int? limit,
    @JsonKey(name: 'convert') @Default("USD") String? convert,
    @JsonKey(name: 'sort') @Default("market_cap") String? sort,
    @JsonKey(name: 'sort_dir') @Default("desc") String? sortDir,
    @JsonKey(name: 'include_metadata') @Default(true) bool? includeMetaData,
  }) = _CoinMarketRequestObject;

  factory CoinMarketRequestObject.fromJson(Map<String, Object?> json) =>
      _$CoinMarketRequestObjectFromJson(json);
}
