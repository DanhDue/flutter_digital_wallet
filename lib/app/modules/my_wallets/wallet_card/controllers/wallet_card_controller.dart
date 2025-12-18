// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'dart:async';

import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/qr_utils.dart';
import 'package:d3_wallet/utils/secure_clipboard.dart';
import 'package:d3_wallet/utils/stream_manager.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class WalletCardController extends BaseController {
  dynamic arguments = Get.arguments;
  final wallet = WalletResponseObject().obs;

  final balanceIsHidden = false.obs;
  late int walletIndex;
  final fullBalance = 0.0.obs;
  final qrData = "".obs;
  final showQRCode = false.obs;
  Timer? showRQCodeTimer;

  // Store subscription reference for proper cleanup
  StreamSubscription<bool>? _balanceVisibilitySubscription;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("WalletCardController onInit");
    wallet.value =
        (arguments as Map?)?[NavigationArguments.wallet] as WalletResponseObject? ??
        WalletResponseObject();
    walletIndex = (arguments as Map?)?[NavigationArguments.walletIndex] as int? ?? 0;

    // Store subscription so we can cancel it later
    _balanceVisibilitySubscription = hiddenBalanceIsChanged.stream.listen((isHidden) {
      balanceIsHidden.value = isHidden;
    });
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("WalletCardController onReady");
    qrData.value = QrUtils.instance.retrieveTransferQRData(wallet.value.address ?? "");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("WalletCardController onClose - cleaning up resources");

    // Cancel timer to prevent it from running after controller is disposed
    showRQCodeTimer?.cancel();
    showRQCodeTimer = null;

    // Cancel stream subscription to prevent memory leak
    _balanceVisibilitySubscription?.cancel();
    _balanceVisibilitySubscription = null;
  }

  void updateWallet(WalletResponseObject? inWallet, int walletIndex) {
    if (inWallet == null || inWallet.address.isNullOrWhiteSpace) return;
    wallet.value = inWallet;
    this.walletIndex = walletIndex;
  }

  hideBalance() {
    hiddenBalanceIsChanged.sink.add(!balanceIsHidden.value);
  }

  void copyAddress() async {
    await SecureClipboard.copySensitive(text: wallet.value.address ?? "", expirySeconds: 30);
    SmartDialog.showToast(
      "",
      builder: (context) {
        return SafeArea(
          bottom: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.appThemes.ink60,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Assets.images.icZeno.image(fit: BoxFit.cover, width: 24, height: 24),
                Flexible(
                  child: Text(
                    LocaleKeys.walletAddressCopiedAndWillBeCleared.tr,
                    style: context.appThemes.regular16.copyWith(color: context.appThemes.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ).marginSymmetric(horizontal: 16),
        );
      },
    );
    showRQCodeTimer?.cancel();
    showQRCode.value = true;
    showRQCodeTimer = Timer(const Duration(seconds: 30), () {
      showQRCode.value = false;
      showRQCodeTimer = null;
    });
  }
}
