// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/network_selection_controller.dart';

class NetworkSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkSelectionController>(() => NetworkSelectionController());
  }
}
