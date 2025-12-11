import 'package:get/get.dart';

import '../controllers/trends_controller.dart';

class TrendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrendsController>(
      () => TrendsController(),
    );
  }
}
