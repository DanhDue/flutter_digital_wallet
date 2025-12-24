// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/coin_market_request_object/coin_market_request_object.dart';
import 'package:d3_wallet/data/bean/response/coin_market_info_map/coin_market_info_map.dart';
import 'package:d3_wallet/data/bean/response/coin_market_ohlcv_map/coin_market_ohlcv_map.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'market_client.g.dart';

@RestApi()
abstract class MarketClient {
  factory MarketClient(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _MarketClient;

  @GET("")
  Future<BaseResponseObject<List<CoinMarketResObject?>?>> getCoins(
    @Queries() CoinMarketRequestObject request,
  );

  @GET("/info")
  Future<BaseResponseObject<CoinMarketInfoMap?>?> getCoinInfo();

  @GET("/price")
  Future<BaseResponseObject<CoinMarketResObject?>?> getCoinPriceConversion();

  @GET("/metrics")
  Future<BaseResponseObject<List<CoinMarketResObject?>?>?> getMetrics();

  @GET("/maps")
  Future<BaseResponseObject<List<CoinMarketResObject?>?>?> getMaps();

  @GET("/ohlcv")
  Future<BaseResponseObject<CoinMarketOhlcvMap?>?> ohlcv();
}
