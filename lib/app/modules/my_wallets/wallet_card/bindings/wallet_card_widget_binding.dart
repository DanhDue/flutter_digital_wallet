// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/wallet_card_controller.dart';

class WalletCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletCardController>(() => WalletCardController());
  }
}
