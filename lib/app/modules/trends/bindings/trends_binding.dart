// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/trends_controller.dart';

class TrendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrendsController>(() => TrendsController());
  }
}
