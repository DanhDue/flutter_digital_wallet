// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/request_payment_results_controller.dart';

class RequestPaymentResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestPaymentResultsController>(() => RequestPaymentResultsController());
  }
}
