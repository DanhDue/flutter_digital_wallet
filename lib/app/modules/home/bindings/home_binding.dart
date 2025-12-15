// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/profile/controllers/profile_controller.dart';
import 'package:d3_wallet/app/modules/qr_scanner/controllers/qr_scanner_controller.dart';
import 'package:d3_wallet/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:d3_wallet/app/modules/trends/controllers/trends_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.lazyPut<TransactionsController>(() => TransactionsController());
    Get.lazyPut<QRScannerController>(() => QRScannerController());
    Get.lazyPut<TrendsController>(() => TrendsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
