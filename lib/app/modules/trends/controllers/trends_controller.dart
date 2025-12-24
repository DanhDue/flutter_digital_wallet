// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/infinite_list/base_infinite_list_controller.dart';
import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/coin_market_request_object/coin_market_request_object.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/repositories/coin_market_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class TrendsController extends BaseInfiniteListController<CoinMarketResObject> {
  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  @override
  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>>
  retrieveDataFromService(int? pageNumber) {
    Fimber.d("retrieveDataFromService(pageNumber: $pageNumber)");
    return Get.find<CoinMarketRepository>().getCoins(
      CoinMarketRequestObject(
        start: ((pageNumber ?? 1) - 1) * defaultItemsPerPageCount + 1,
        limit: defaultItemsPerPageCount,
      ),
    );
  }
}
