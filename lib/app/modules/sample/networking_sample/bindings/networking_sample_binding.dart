// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/networking_sample_controller.dart';

class NetworkingSampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkingSampleController>(
      () => NetworkingSampleController(),
    );
  }
}
