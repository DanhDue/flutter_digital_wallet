// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/comming_soon_modal_controller.dart';

class CommingSoonModalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommingSoonModalController>(() => CommingSoonModalController());
  }
}
