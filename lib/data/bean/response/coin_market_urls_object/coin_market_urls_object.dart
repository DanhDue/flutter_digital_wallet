// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'coin_market_urls_object.freezed.dart';
part 'coin_market_urls_object.g.dart';

@freezed
abstract class CoinMarketUrlsObject with _$CoinMarketUrlsObject {
  const factory CoinMarketUrlsObject({
    @JsonKey(name: 'website') List<String>? website,
    @JsonKey(name: 'twitter') List<String>? twitter,
    @JsonKey(name: 'message_board') List<String>? messageBoard,
    @JsonKey(name: 'chat') List<String>? chat,
    @JsonKey(name: 'facebook') List<String>? facebook,
    @JsonKey(name: 'explorer') List<String>? explorer,
    @JsonKey(name: 'reddit') List<String>? reddit,
    @JsonKey(name: 'technical_doc') List<String>? technicalDoc,
    @JsonKey(name: 'source_code') List<String>? sourceCode,
    @JsonKey(name: 'announcement') List<String>? announcement,
  }) = _CoinMarketUrlsObject;

  factory CoinMarketUrlsObject.fromJson(Map<String, Object?> json) =>
      _$CoinMarketUrlsObjectFromJson(json);
}
