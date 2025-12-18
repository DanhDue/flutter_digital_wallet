// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/my_tokens_controller.dart';

class MyTokensBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTokensController>(() => MyTokensController());
  }
}
