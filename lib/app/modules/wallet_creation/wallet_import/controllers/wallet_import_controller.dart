// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class WalletImportController extends BaseController with NetworkingMixin {
  dynamic arguments = Get.arguments;

  final walletRepo = Get.find<WalletRepository>();

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
  String? deviceToken;
  String? privateKey;
  String? bs58PrivateKey;
  String? mnemonics;

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

  _validateSRPOrPk() {
    // check if it's a mnemonic
    isMnemonic.value = bip39.validateMnemonic(srpOrPk ?? "") && srpOrPk?.isNotEmpty == true;
    if (isMnemonic.value) {
      isValid.value = true;
      isMnemonicError.value = false;
      mnemonics = srpOrPk;
      return;
    }
    // If not a mnemonic, check if it's a Solana private key
    final isPrivateKey = _isSolanaPrivateKey(srpOrPk ?? "");

    if (isPrivateKey) {
      isMnemonic.value = false; // It's a private key, not a mnemonic
      isValid.value = true;
      isMnemonicError.value = false;
    } else {
      // Neither mnemonic nor valid private key
      isValid.value = false;
      isMnemonicError.value = true;
    }
  }

  bool _isSolanaPrivateKey(String input) {
    if (input.isEmpty) return false;

    final trimmed = input.trim();

    // Check if it's a byte array format like [30, 11, 190, ...]
    if (_isValidByteArray(trimmed)) {
      privateKey = trimmed;
      return true;
    }

    // Check if it's a Base58 encoded private key (most common format)
    // Solana private keys in Base58 are typically 87-88 characters
    if (_isValidBase58(trimmed) && trimmed.length >= 87 && trimmed.length <= 88) {
      bs58PrivateKey = trimmed;
      return true;
    }

    // Check if it's a hex string (64 bytes = 128 hex characters)
    if (_isValidHex(trimmed) && trimmed.length == 128) {
      privateKey = trimmed;
      return true;
    }

    return false;
  }

  bool _isValidBase58(String input) {
    // Base58 alphabet (Bitcoin/Solana uses this)
    final base58Regex = RegExp(r'^[1-9A-HJ-NP-Za-km-z]+$');
    return base58Regex.hasMatch(input);
  }

  bool _isValidHex(String input) {
    final hexRegex = RegExp(r'^[0-9a-fA-F]+$');
    return hexRegex.hasMatch(input);
  }

  bool _isValidByteArray(String input) {
    try {
      // Check if it looks like a JSON array
      if (!input.startsWith('[') || !input.endsWith(']')) {
        return false;
      }

      // Try to parse as JSON
      final dynamic decoded = jsonDecode(input);

      if (decoded is! List) {
        return false;
      }

      // Check if all elements are integers and within byte range (0-255)
      for (final element in decoded) {
        if (element is! int || element < 0 || element > 255) {
          return false;
        }
      }

      // Solana private keys are either 32 bytes (seed) or 64 bytes (full keypair)
      final length = decoded.length;
      return length == 32 || length == 64;
    } catch (e) {
      return false;
    }
  }

  void restoreWallet() async {
    Fimber.d("restoreWallet()");
    isLoading.value = true;
    callApi(
      walletRepo.createOrRestoreWallet(
        mnemonics: mnemonics,
        privateKey: privateKey,
        bs58PrivateKey: bs58PrivateKey,
        deviceToken: deviceToken,
      ),
      onSuccess: (response) async {
        Fimber.d("createOrRestoreWallet() onSuccess: $response");
        isLoading.value = false;
        if (response?.data != null) {
          try {
            await updateWallets(response!.data!);
            Get.toNamed(Routes.HOME);
          } catch (e) {
            Fimber.e("Failed to update wallets: $e");
            SmartDialog.showToast(LocaleKeys.cannotCreateWalletError.tr);
          }
        } else {
          SmartDialog.showToast(LocaleKeys.cannotCreateWalletError.tr);
        }
      },
      onError: (error) {
        Fimber.d("createOrRestoreWallet() onError: $error");
        isLoading.value = false;
        SmartDialog.showToast(error.message ?? LocaleKeys.cannotCreateWalletError.tr);
      },
    );
  }

  void scannedText(String? mnemonics) {
    Fimber.d("scannedText(mnemonics: $mnemonics)");
    textEditingController?.text = mnemonics ?? "";
    onTextChanged(mnemonics ?? "");
    keyboardVisibilityChanged(false);
  }

  updateWallets(WalletResponseObject wallet) async {
    final yourWallets = await walletRepo.retrieveYourWallets();
    final oldWallet = yourWallets?.firstOrNullWhere((item) => item?.address == wallet.address);
    if (oldWallet != null) {
      final oldWalletIndex = yourWallets?.indexOf(oldWallet);
      if (oldWalletIndex?.isGreaterThan(-1) == true) {
        yourWallets?.removeAt(oldWalletIndex!);
        yourWallets?.insert(
          oldWalletIndex!,
          oldWallet.copyWith(scrIsBackedUp: true, scrBackupReminderIsShown: true),
        );
        await walletRepo.updateYourWallets(yourWallets);
      }
    } else {
      await walletRepo.updateYourWallets([...?yourWallets, wallet]);
    }
  }
}
