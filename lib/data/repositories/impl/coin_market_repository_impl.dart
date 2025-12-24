// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/coin_market_request_object/coin_market_request_object.dart';
import 'package:d3_wallet/data/bean/response/coin_market_ohlcv_map/coin_market_ohlcv_map.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/market_client/market_client.dart';
import 'package:d3_wallet/data/repositories/coin_market_repository.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class CoinMarketRepositoryImpl extends CoinMarketRepository with SafeCallApiMixin {
  final marketClient = Get.find<MarketClient>();

  @override
  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>> getCoins(
    CoinMarketRequestObject request,
  ) => safeApiCall(() => marketClient.getCoins(request));

  @override
  Future<Result<BaseResponseObject<CoinMarketResObject?>, ApiError>> getCoinPriceConversion() {
    throw UnimplementedError();
  }

  @override
  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>> getMetrics() {
    throw UnimplementedError();
  }

  @override
  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>> getMaps() {
    throw UnimplementedError();
  }

  @override
  Future<Result<BaseResponseObject<CoinMarketOhlcvMap?>, ApiError>> ohlcv() {
    throw UnimplementedError();
  }
}
