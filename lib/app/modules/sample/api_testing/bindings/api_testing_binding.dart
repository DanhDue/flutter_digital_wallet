// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/api_testing_controller.dart';

class ApiTestingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiTestingController>(() => ApiTestingController());
  }
}
