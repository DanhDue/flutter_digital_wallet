// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/my_wallets_controller.dart';

class MyWalletsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletsController>(() => MyWalletsController());
  }
}
