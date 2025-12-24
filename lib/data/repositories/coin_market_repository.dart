// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/coin_market_request_object/coin_market_request_object.dart';
import 'package:d3_wallet/data/bean/response/coin_market_ohlcv_map/coin_market_ohlcv_map.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';

abstract class CoinMarketRepository {
  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>> getCoins(
    CoinMarketRequestObject request,
  );

  Future<Result<BaseResponseObject<CoinMarketResObject?>, ApiError>> getCoinPriceConversion();

  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>> getMetrics();

  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>> getMaps();

  Future<Result<BaseResponseObject<CoinMarketOhlcvMap?>, ApiError>> ohlcv();
}
