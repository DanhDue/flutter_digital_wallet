// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/coin_market_ohlcv_res_object/coin_market_ohlcv_res_object.dart';
import 'package:d3_wallet/data/converters/map_json_converter.dart';

/// Wrapper class for deserializing Map<String, CoinMarketOhlcvResObject> from JSON.
/// The JSON is expected to be a map directly, not nested under a "data" field.
class CoinMarketOhlcvMap {
  final Map<String, CoinMarketOhlcvResObject> data;

  CoinMarketOhlcvMap({required this.data});

  factory CoinMarketOhlcvMap.fromJson(Map<String, dynamic> json) {
    const converter = MapJsonConverter(CoinMarketOhlcvResObject.fromJson);
    return CoinMarketOhlcvMap(data: converter.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    const converter = MapJsonConverter(CoinMarketOhlcvResObject.fromJson);
    return converter.toJson(data);
  }
}
