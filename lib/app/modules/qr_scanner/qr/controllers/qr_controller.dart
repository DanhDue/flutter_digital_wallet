// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/utils/qr_utils.dart';
import 'package:d3_wallet/utils/stream_manager.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class QRController extends BaseController {
  dynamic arguments = Get.arguments;
  final selectedWallet = WalletResponseObject().obs;
  final qrData = "".obs;

  final showFullScreen = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    showFullScreen.value = retrieveArgument<bool>(NavigationArguments.qr.showFullScreen) ?? false;
    selectedWallet.value =
        retrieveArgument<WalletResponseObject>(NavigationArguments.wallet) ??
        WalletResponseObject();
    Fimber.d("showFullScreen: ${showFullScreen.value}");
    walletIsChanged.stream.listen((event) {
      Fimber.d("notificationStream event: ${event.toJson().encodedJsonString}");
      selectedWallet.value = event;
    });
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    qrData.value = QrUtils.instance.retrieveTransferQRData(selectedWallet.value.address ?? "");
  }

  @override
  void onClose() {
    Fimber.d("onClose()");
    super.onClose();
  }

  void updateSelectedWallet(WalletResponseObject? wallet) {
    if (wallet == null || wallet.address.isNullOrWhiteSpace) return;
    selectedWallet.value = wallet;
  }
}
