// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/qr_scanning_controller.dart';

class QRScanningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRScanningController>(() => QRScanningController());
  }
}
