// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:bip39/bip39.dart' as bip39;
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WalletImportController extends BaseController with NetworkingMixin {
  dynamic arguments = Get.arguments;

  late TextEditingController? textEditingController;
  late FocusNode? focusNode;
  final isFocus = false.obs;
  final isValidated = false.obs;
  String? srpOrPk;
  final showClearIcon = false.obs;
  final keyboardIsVisible = false.obs;
  final isMnemonic = true.obs;
  final isMnemonicError = false.obs;
  final isValid = false.obs;

  late final Rx<WalletResponseObject?> wallet = WalletResponseObject().obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    _handleTextFieldFocus();
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
    textEditingController?.dispose();
    focusNode?.dispose();
  }

  _handleTextFieldFocus() {
    Fimber.d("_handleTextFieldFocus");
    focusNode?.addListener(() {
      if (focusNode?.hasFocus == true) {
        isFocus.value = true;
        if (srpOrPk?.isNotEmpty == true) showClearIcon.value = true;
      } else {
        _validateSRPOrPk();
        isFocus.value = false;
        if (srpOrPk?.isNotEmpty == true) {
          showClearIcon.value = true;
        } else {
          showClearIcon.value = false;
        }
      }
    });
  }

  void onTextChanged(String srp) {
    Fimber.d("onTextChanged(srp: $srp)");
    srpOrPk = srp;
    showClearIcon.value = true;
    isMnemonic.value = true;
    isValid.value = false;
  }

  void clearText() {
    textEditingController?.clear();
    srpOrPk = '';
    showClearIcon.value = false;
    isMnemonic.value = true;
    isValid.value = false;
    isMnemonicError.value = false;
  }

  void keyboardVisibilityChanged(bool visible) {
    Fimber.d("keyboardVisibilityChanged(visible: $visible)");
    keyboardIsVisible.value = visible;
    if (!visible && srpOrPk?.isNotEmpty == true) _validateSRPOrPk();
  }

  void _validateSRPOrPk() {
    isMnemonic.value = bip39.validateMnemonic(srpOrPk ?? "") && srpOrPk?.isNotEmpty == true;
    if (isMnemonic.value) {
      isValid.value = true;
      isMnemonicError.value = false;
    } else {
      if (srpOrPk?.isNotEmpty == true) {
        isMnemonicError.value = true;
      } else {
        isMnemonicError.value = false;
      }
      isValid.value = false;
    }
  }

  void restoreWallet() async {
    Fimber.d("restoreWallet()");
    isLoading.value = true;
  }

  void scannedText(String? mnemonics) {
    Fimber.d("scannedText(mnemonics: $mnemonics)");
    textEditingController?.text = mnemonics ?? "";
    onTextChanged(mnemonics ?? "");
    keyboardVisibilityChanged(false);
  }
}
