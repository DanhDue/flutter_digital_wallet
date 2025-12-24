// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/coin_market_detail_controller.dart';

class CoinMarketDetailBinding extends Bindings {
  final Object? arguments;
  CoinMarketDetailBinding({this.arguments});

  @override
  void dependencies() {
    Get.lazyPut<CoinMarketDetailController>(
      () => CoinMarketDetailController(arguments: arguments),
    );
  }
}
