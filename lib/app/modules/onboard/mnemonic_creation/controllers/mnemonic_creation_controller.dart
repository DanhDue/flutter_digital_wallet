// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

class MnemonicCreationController extends BaseController {
  final secretRecoveryPhraseIsGenerated = false.obs;
  late final Rx<WalletResponseObject?> wallet = WalletResponseObject().obs;

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

  void generateSecretRecoveryPhrase() async {
    Fimber.d("generateSecretRecoveryPhrase()");
    secretRecoveryPhraseIsGenerated.value = true;
  }

  void setInputs(WalletResponseObject? createdWallet) {
    wallet.value = createdWallet;
  }
}
