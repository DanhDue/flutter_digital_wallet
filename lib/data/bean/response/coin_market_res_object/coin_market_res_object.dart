// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/coin_market_platform_object/coin_market_platform_object.dart';
import 'package:d3_wallet/data/bean/response/coin_market_urls_object/coin_market_urls_object.dart';
import 'package:d3_wallet/utils/json_converter/jiffy_long_json_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jiffy/jiffy.dart';

part 'coin_market_res_object.freezed.dart';
part 'coin_market_res_object.g.dart';

@freezed
abstract class CoinMarketResObject with _$CoinMarketResObject {
  const factory CoinMarketResObject({
    @JsonKey(name: 'timestamp') String? timestamp,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'num_market_pairs') int? numMarketPairs,
    @JsonKey(name: 'date_added') String? dateAdded,
    @JsonKey(name: 'max_supply') int? maxSupply,
    @JsonKey(name: 'circulating_supply') int? circulatingSupply,
    @JsonKey(name: 'total_supply') int? totalSupply,
    @JsonKey(name: 'is_active') int? isActive,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'infinite_supply') bool? infiniteSupply,
    @JsonKey(name: 'minted_market_cap') double? mintedMarketCap,
    @JsonKey(name: 'platform') CoinMarketPlatformObject? platform,
    @JsonKey(name: 'cmc_rank') int? cmcRank,
    @JsonKey(name: 'rank') int? rank,
    @JsonKey(name: 'is_fiat') int? isFiat,
    @JsonKey(name: 'self_reported_circulating_supply') dynamic selfReportedCirculatingSupply,
    @JsonKey(name: 'self_reported_market_cap') dynamic selfReportedMarketCap,
    @JsonKey(name: 'tvl_ratio') dynamic tvlRatio,
    @JsonKey(name: 'last_updated') String? lastUpdated,
    @JsonKey(name: 'convert') String? convert, // currency to convert to such as USD, VND etc.
    @JsonKey(name: 'amount') double? amount, // amount to convert
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'volume_24h') double? volume24h,
    @JsonKey(name: 'volume_change_24h') double? volumeChange24h,
    @JsonKey(name: 'percent_change_1h') double? percentChange1h,
    @JsonKey(name: 'percent_change_24h') double? percentChange24h,
    @JsonKey(name: 'percent_change_7d') double? percentChange7d,
    @JsonKey(name: 'percent_change_30d') double? percentChange30d,
    @JsonKey(name: 'percent_change_60d') double? percentChange60d,
    @JsonKey(name: 'percent_change_90d') double? percentChange90d,
    @JsonKey(name: 'market_cap') double? marketCap,
    @JsonKey(name: 'market_cap_dominance') double? marketCapDominance,
    @JsonKey(name: 'fully_diluted_market_cap') double? fullyDilutedMarketCap,
    @JsonKey(name: 'tvl') dynamic tvl,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'subreddit') String? subreddit,
    @JsonKey(name: 'notice') String? notice,
    @JsonKey(name: 'urls') CoinMarketUrlsObject? urls,
    @JsonKey(name: 'twitter_username') String? twitterUsername,
    @JsonKey(name: 'is_hidden') int? isHidden,
    @JsonKey(name: 'date_launched') String? dateLaunched,
    @JsonKey(name: 'contract_address') List<String>? contractAddress,
    @JsonKey(name: 'open_time') @JiffyLongJsonConverter() Jiffy? openTime,
    @JsonKey(name: 'open') double? open,
    @JsonKey(name: 'high') double? high,
    @JsonKey(name: 'low') double? low,
    @JsonKey(name: 'close') double? close,
    @JsonKey(name: 'volume') double? volume,
    @JsonKey(name: 'close_time') @JiffyLongJsonConverter() Jiffy? closeTime,
    @JsonKey(name: 'quote_asset_volume') double? quoteAssetVolume,
    @JsonKey(name: 'number_of_trades') int? numberOfTrades,
  }) = _CoinMarketResObject;

  factory CoinMarketResObject.fromJson(Map<String, Object?> json) =>
      _$CoinMarketResObjectFromJson(json);
}
