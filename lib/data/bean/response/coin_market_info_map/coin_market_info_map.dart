// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:d3_wallet/data/converters/map_json_converter.dart';

/// Wrapper class for deserializing Map<String, CoinMarketResObject> from JSON.
/// The JSON is expected to be a map directly, not nested under a "data" field.
class CoinMarketInfoMap {
  final Map<String, CoinMarketResObject> data;

  CoinMarketInfoMap({required this.data});

  factory CoinMarketInfoMap.fromJson(Map<String, dynamic> json) {
    const converter = MapJsonConverter(CoinMarketResObject.fromJson);
    return CoinMarketInfoMap(data: converter.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    const converter = MapJsonConverter(CoinMarketResObject.fromJson);
    return converter.toJson(data);
  }
}
