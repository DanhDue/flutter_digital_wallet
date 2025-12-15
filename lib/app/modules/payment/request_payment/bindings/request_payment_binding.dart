// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/request_payment_controller.dart';

class RequestPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestPaymentController>(() => RequestPaymentController());
  }
}
