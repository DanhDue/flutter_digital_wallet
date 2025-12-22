// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'coin_market_ohlcv_res_object.freezed.dart';
part 'coin_market_ohlcv_res_object.g.dart';

@freezed
abstract class CoinMarketOhlcvResObject with _$CoinMarketOhlcvResObject {
  const factory CoinMarketOhlcvResObject({
    @JsonKey(name: 'open_time') int? openTime,
    @JsonKey(name: 'open') double? open,
    @JsonKey(name: 'high') double? high,
    @JsonKey(name: 'low') double? low,
    @JsonKey(name: 'close') double? close,
    @JsonKey(name: 'volume') double? volume,
    @JsonKey(name: 'close_time') int? closeTime,
    @JsonKey(name: 'quote_asset_volume') double? quoteAssetVolume,
    @JsonKey(name: 'number_of_trades') int? numberOfTrades,
  }) = _CoinMarketOhlcvResObject;

  factory CoinMarketOhlcvResObject.fromJson(Map<String, Object?> json) =>
      _$CoinMarketOhlcvResObjectFromJson(json);
}
