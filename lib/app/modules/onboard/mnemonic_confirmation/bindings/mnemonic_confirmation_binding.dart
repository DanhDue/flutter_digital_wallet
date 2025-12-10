// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/mnemonic_confirmation_controller.dart';

class MnemonicConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MnemonicConfirmationController>(() => MnemonicConfirmationController());
  }
}
