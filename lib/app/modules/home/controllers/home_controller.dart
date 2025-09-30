// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
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
      if (isClosed) return;
      liveChatBotIsDancing.value = true;
    });
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
