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

  static int get HEALTH_CHECK_RETRY_INTERVAL => 6;
  static int get START_ZENO_SERVICE_INTERVAL => 38;
  static int get START_SPLASH_ANIMATION_INTERVAL => 850;

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
    Future.delayed(Duration(milliseconds: START_SPLASH_ANIMATION_INTERVAL), () {
      liveChatBotIsDancing.value = true;
    });
    final serviceIsLive = await healthz();
    final delayTime = serviceIsLive ? HEALTH_CHECK_RETRY_INTERVAL : START_ZENO_SERVICE_INTERVAL;
    Future.delayed(Duration(seconds: delayTime), () {
      if (serviceIsLive) {
        Get.offAllNamed(Routes.HOME);
      } else {
        healthz(isLoop: true);
      }
    });
  }

  Future<bool> healthz({bool isLoop = false}) async {
    try {
      final healthzResponse = await appConfigsRepository.healthz();
      switch (healthzResponse) {
        case Success(data: final response):
          showRestartServiceWarning.value = false;
          if (isLoop) Get.offAllNamed(Routes.HOME);
          return response?.success == true;
        case Failure(:final error):
          error.printError();
          showRestartServiceWarning.value = true;
          if (isLoop) {
            Future.delayed(Duration(seconds: HEALTH_CHECK_RETRY_INTERVAL), () {
              healthz(isLoop: true);
            });
          }
          return false;
      }
    } catch (exception) {
      exception.printError();
      if (isLoop) {
        Future.delayed(Duration(seconds: HEALTH_CHECK_RETRY_INTERVAL), () {
          healthz(isLoop: true);
        });
      }
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }
}
