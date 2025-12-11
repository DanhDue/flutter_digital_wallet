// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/wallet_token_info_controller.dart';

class WalletTokenInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletTokenInfoController>(() => WalletTokenInfoController());
  }
}
