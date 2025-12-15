// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/utils/stream_manager.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class QRScannerController extends BaseController {
  final onStartQRCodeScanner = false.obs;
  final appConfigsRepository = Get.find<AppConfigsRepository>();
  late AppConfigurations? appConfigurations;
  final selectedWallet = WalletResponseObject().obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    onStartQRCodeScanner.value = true;
    _loadAppConfig();
  }

  @override
  void onClose() {
    Fimber.d("onClose()");
    onStartQRCodeScanner.value = false;
    super.onClose();
  }

  _loadAppConfig() async {
    Fimber.d("_loadAppConfig()");
    appConfigurations =
        await appConfigsRepository.retrieveAppConfigurations() ?? AppConfigurations();
    walletIsChanged.stream.listen((event) {
      Fimber.d("notificationStream event: ${event.toJson().encodedJsonString}");
      selectedWallet.value = event;
    });
  }

  void setupInputs(WalletResponseObject? selectedWallet) {
    this.selectedWallet.value = selectedWallet ?? WalletResponseObject();
  }
}
