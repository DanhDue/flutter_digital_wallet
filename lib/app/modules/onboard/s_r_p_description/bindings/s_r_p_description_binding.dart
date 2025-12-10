// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';

import '../controllers/s_r_p_description_controller.dart';

class SRPDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SRPDescriptionController>(() => SRPDescriptionController());
  }
}
