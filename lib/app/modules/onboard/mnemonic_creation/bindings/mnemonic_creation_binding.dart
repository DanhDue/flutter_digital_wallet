// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/mnemonic_creation_controller.dart';

class MnemonicCreationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MnemonicCreationController>(() => MnemonicCreationController());
  }
}
