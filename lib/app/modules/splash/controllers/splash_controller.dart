// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  final liveChatBotIsShown = false.obs;
  final liveChatBotIsDancing = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() async {
    super.onReady();
    Fimber.d("onReady()");
    liveChatBotIsShown.value = true;
    Future.delayed(const Duration(milliseconds: 850), () {
      liveChatBotIsDancing.value = true;
    });
    Future.delayed(const Duration(seconds: 6), () {
      Get.toNamed(Routes.HOME);
    });
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
