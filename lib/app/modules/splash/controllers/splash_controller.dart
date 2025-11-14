// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  final appConfigsRepository = Get.find<AppConfigsRepository>();

  final liveChatBotIsShown = false.obs;
  final liveChatBotIsDancing = false.obs;
  final showRestartServiceWarning = false.obs;

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
    final serviceIsLive = await healthz();
    final delayTime = serviceIsLive ? 6 : 38;
    Future.delayed(Duration(seconds: delayTime), () {
      Get.toNamed(Routes.HOME);
    });
  }

  Future<bool> healthz() async {
    try {
      final healthzResponse = await appConfigsRepository.healthz();
      switch (healthzResponse) {
        case Success(data: final response):
          showRestartServiceWarning.value = false;
          return response?.success == true;
        case Failure(:final error):
          error.printError();
          showRestartServiceWarning.value = true;
          return false;
      }
    } catch (exception) {
      exception.printError();
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
