// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/utils/stream_manager.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class ScannerController extends BaseController {
  dynamic arguments = Get.arguments;

  final showFullScreen = false.obs;

  final selectedWallet = WalletResponseObject().obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    walletIsChanged.stream.listen((event) {
      Fimber.d("notificationStream event: ${event.toJson().encodedJsonString}");
      selectedWallet.value = event;
    });
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady(): ${(arguments as Map?)?["showFullScreen"]}");
    showFullScreen.value = (arguments as Map?)?["showFullScreen"] ?? false;
  }

  @override
  void onClose() {
    Fimber.d("onClose()");
    super.onClose();
  }

  void setupInputs(WalletResponseObject? selectedWallet) {
    this.selectedWallet.value = selectedWallet ?? WalletResponseObject();
  }
}
