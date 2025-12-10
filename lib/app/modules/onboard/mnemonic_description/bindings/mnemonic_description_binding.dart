// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/mnemonic_description_controller.dart';

class MnemonicDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MnemonicDescriptionController>(() => MnemonicDescriptionController());
  }
}
