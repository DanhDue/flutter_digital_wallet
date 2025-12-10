// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OnboardController extends BaseController {
  late AppConfigurations? appConfigurations;
  final passwordIsCreated = false.obs;
  final mnemonicIsShown = false.obs;
  final mnemonicIsVerified = false.obs;
  final currentPage = 0.obs;

  late final Rx<WalletResponseObject?> wallet = WalletResponseObject().obs;

  final passwordAndWalletIsCreated = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  void updateCreatedAppConfigurations(
    WalletResponseObject? wallet,
    AppConfigurations? appConfigurations,
  ) {
    this.appConfigurations = appConfigurations ?? AppConfigurations();
    passwordIsCreated.value = true;
  }

  mnemonicIsGenereated() {
    mnemonicIsShown.value = true;
  }

  createWalletAndSaveAppConfigurations({bool? toHome = false}) async {
    isLoading.value = true;
  }

  void updateMnemonicIsVerified(bool isVerified) {
    mnemonicIsVerified.value = isVerified;
  }

  void jumpToPage(int i) {
    currentPage.value = i;
  }
}
