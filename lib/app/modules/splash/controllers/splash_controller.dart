// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// ignore_for_file: non_constant_identifier_names

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/utils/biometric_auth/biometric_authenticator.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  final appConfigsRepository = Get.find<AppConfigsRepository>();
  late AppConfigurations? appConfigurations;
  final BiometricAuthenticator biometricAuthenticator = Get.find();
  final walletRepo = Get.find<WalletRepository>();

  final liveChatBotIsShown = false.obs;
  final liveChatBotIsDancing = false.obs;
  final showRestartServiceWarning = false.obs;

  static int get HEALTH_CHECK_RETRY_INTERVAL => 4000; // 4 seconds
  // static int get START_ZENO_SERVICE_INTERVAL => 46000; // 46 seconds
  static int get START_ZENO_SERVICE_INTERVAL => 16000; // 46 seconds
  static int get START_SPLASH_ANIMATION_INTERVAL => 850; // 850 milliseconds
  late int startTime;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() async {
    super.onReady();
    Fimber.d("onReady()");
    startTime = DateTime.now().millisecondsSinceEpoch;
    _loadAppConfig();
    liveChatBotIsShown.value = true;
    Future.delayed(Duration(milliseconds: START_SPLASH_ANIMATION_INTERVAL), () {
      liveChatBotIsDancing.value = true;
    });
    final serviceIsLive = await healthz();
    if (serviceIsLive) {
      checkLogin();
    } else {
      Future.delayed(Duration(milliseconds: START_ZENO_SERVICE_INTERVAL), () {
        healthz(isLoop: true);
      });
    }
  }

  _pendingNavigation(String route) {
    final checkingTime = DateTime.now().millisecondsSinceEpoch - startTime;
    Fimber.d("_pendingNavigation() =>Checking time: $checkingTime");
    Future.delayed(Duration(milliseconds: HEALTH_CHECK_RETRY_INTERVAL - checkingTime), () {
      Get.offAllNamed(route);
    });
  }

  _loadAppConfig() async {
    Fimber.d("_loadAppConfig()");
    appConfigurations =
        await appConfigsRepository.retrieveAppConfigurations() ?? AppConfigurations();
  }

  @visibleForTesting
  checkLogin() async {
    final appConfigurations = await appConfigsRepository.retrieveAppConfigurations();
    Fimber.d("App configurations: $appConfigurations");
    if (appConfigurations == null) {
      Future.delayed(ToastDuration.LENGTH_SHORT, () {
        isLoading.value = false;
        _pendingNavigation(Routes.START);
      });
    } else {
      // check biometric logging.
      if (appConfigurations.isBiometricsLogin == true) {
        isLoading.value = false;
        Fimber.d("Need to show the biometric login.");
        handleBiometricLogin();
      } else {
        isLoading.value = false;
        _pendingNavigation(Routes.LOGIN);
      }
    }
  }

  @visibleForTesting
  handleBiometricLogin() async {
    Fimber.d("handleBiometricLogin()");
    final biometricAuthIsSupported = await biometricAuthenticator.deviceIsSupported();
    final yourWallets = await walletRepo.retrieveYourWallets();
    if (biometricAuthIsSupported) {
      final authenticated = await biometricAuthenticator.authenticateWithBiometrics(
        LocaleKeys.bimometricDescription.tr,
      );
      if (authenticated) {
        if (yourWallets?.isNotEmpty == true) {
          _pendingNavigation(Routes.HOME);
        } else {
          _pendingNavigation(Routes.WALLET_CREATION);
        }
      } else {
        _pendingNavigation(Routes.LOGIN);
      }
    } else {
      _pendingNavigation(Routes.LOGIN);
    }
  }

  @visibleForTesting
  Future<bool> healthz({bool isLoop = false}) async {
    try {
      final healthzResponse = await appConfigsRepository.healthz();
      switch (healthzResponse) {
        case Success(data: final response):
          showRestartServiceWarning.value = false;
          if (isLoop) checkLogin();
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
