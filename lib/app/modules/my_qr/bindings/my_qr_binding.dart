// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/my_qr_controller.dart';

class MyQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyQrController>(() => MyQrController());
  }
}
