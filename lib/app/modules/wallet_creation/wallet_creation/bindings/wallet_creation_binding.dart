// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/wallet_creation_controller.dart';

class WalletCreationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletCreationController>(() => WalletCreationController());
  }
}
