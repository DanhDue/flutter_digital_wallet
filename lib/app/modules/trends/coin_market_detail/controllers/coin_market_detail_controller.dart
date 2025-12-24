// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class CoinMarketDetailController extends BaseController {
  CoinMarketDetailController({Object? arguments}) : super(constructorArgs: arguments);

  final coinMarketInfo = CoinMarketResObject().obs;
  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    coinMarketInfo.value =
        retrieveArgument<CoinMarketResObject>(NavigationArguments.coinMarketInfo) ??
        CoinMarketResObject();
    Fimber.d("coinMarketInfo: ${coinMarketInfo.value.name}");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
