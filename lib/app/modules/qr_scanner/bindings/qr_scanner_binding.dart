// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/qr_scanner_controller.dart';

class QRScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRScannerController>(() => QRScannerController());
  }
}
