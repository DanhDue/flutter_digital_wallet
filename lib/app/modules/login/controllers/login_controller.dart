// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/utils/biometric_auth/biometric_authenticator.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final appConfigsRepository = Get.find<AppConfigsRepository>();
  late AppConfigurations? appConfigurations;
  final keyboardIsVisible = false.obs;
  final walletRepo = Get.find<WalletRepository>();
  late TextEditingController? passwordTextEditingController;
  late FocusNode? passwordFocusNode;
  final passwordIsFocus = false.obs;
  String? password;
  final showPasswordClearIcon = false.obs;
  final obscurePassword = true.obs;
  final count = 0.obs;
  final passError = "".obs;
  final enableUnlockButton = false.obs;

  final BiometricAuthenticator biometricAuthenticator = Get.find();
  final biometricLoginIsEnable = false.obs;
  final showBiometricLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("LoginController initialized");
    passwordTextEditingController = TextEditingController();
    passwordFocusNode = FocusNode();
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("LoginController is ready");
    _handlePasswordTextFieldFocus();
    _checkBiometricLogin();
  }

  @override
  void onClose() {
    Fimber.d("LoginController is closed");
    passwordTextEditingController?.dispose();
    passwordFocusNode?.dispose();
    super.onClose();
  }

  _handlePasswordTextFieldFocus() {
    Fimber.d("_handlePasswordTextFieldFocus");
    passwordFocusNode?.addListener(() {
      if (passwordFocusNode?.hasFocus == true) {
        passwordIsFocus.value = true;
        if (password?.isNotEmpty == true) showPasswordClearIcon.value = true;
      } else {
        // đóng keyboard mà đang lỗi => Ko sửa gì mà đang lỗi => Vẫn lỗi
        // => Ko cần validate
        if (passError.value.isNotBlank != true) _validatePassword();
        passwordIsFocus.value = false;
        if (password?.isNotEmpty == true) {
          showPasswordClearIcon.value = true;
        } else {
          showPasswordClearIcon.value = false;
        }
      }
    });
  }

  passwordTextChanged(String? password) {
    Fimber.d("passwordTextChanged(String? $password)");
    this.password = password;
    showPasswordClearIcon.value = true;
    // Text đang thay đổi => Input value đã đổi:
    // 1. Validate.
    // 2. Cập nhật trạng thái button.
    if (passError.value.isNotBlank == true) _validatePassword();
    enableUnlockButton.value = _validatePassword(ignorePassError: true);
    passwordIsFocus.value = true;
  }

  clearPassword() {
    Fimber.d("clearPassword()");
    passwordTextEditingController?.clear();
    password = '';
    showPasswordClearIcon.value = false;
    passError.value = "";
    enableUnlockButton.value = false;
  }

  bool _validatePassword({bool? ignorePassError = false}) {
    Fimber.d("_validatePassword()");
    if (password?.isNotBlank == true) {
      if (password?.length.isLowerThan(8) == true) {
        if (ignorePassError != true) passError.value = LocaleKeys.passwordLengthError.tr;
        return false;
      } else {
        passError.value = "";
        return true;
      }
    } else {
      passError.value = "";
      return false;
    }
  }

  void checkPassword() async {
    Fimber.d("checkPassword()");
    isLoading.value = true;
    appConfigurations = await appConfigsRepository.retrieveAppConfigurations();
    final yourWallets = await walletRepo.retrieveYourWallets();
    Fimber.d("appConfig: $appConfigurations");
    if (password.equalsIgnoreCase(appConfigurations?.localPasswords) == true) {
      isLoading.value = false;
      if (yourWallets?.isNotEmpty == true) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.WALLET_CREATION);
      }
    } else {
      isLoading.value = false;
      passError.value = LocaleKeys.passwordErrorMessage.tr;
      enableUnlockButton.value = false;
      passwordIsFocus.value = false;
    }
  }

  void reimportWallets() async {
    await appConfigsRepository.clearAppData();
    await walletRepo.clear();
    Get.toNamed(Routes.WALLET_CREATION);
  }

  _checkBiometricLogin() async {
    Fimber.d("_checkBiometricLogin()");
    final biometricAuthIsSupported = await biometricAuthenticator.deviceIsSupported();
    appConfigurations = await appConfigsRepository.retrieveAppConfigurations();
    if (appConfigurations?.isBiometricsLogin == true && biometricAuthIsSupported) {
      showBiometricLogin.value = true;
    } else {
      showBiometricLogin.value = false;
    }
  }

  handleBiometricLogin() async {
    Fimber.d("handleBiometricLogin()");
    final yourWallets = await walletRepo.retrieveYourWallets();
    final biometricAuthIsSupported = await biometricAuthenticator.deviceIsSupported();
    if (biometricAuthIsSupported) {
      final authenticated = await biometricAuthenticator.authenticateWithBiometrics(
        LocaleKeys.bimometricDescription.tr,
      );
      if (authenticated) {
        if (yourWallets?.isNotEmpty == true) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.WALLET_CREATION);
        }
      }
    }
  }

  void keyboardVisibilityChanged(bool visible) {
    Fimber.d("keyboardVisibilityChanged($visible)");
    Future.delayed(Duration(milliseconds: visible ? 0 : Constants.keyboardDismissDuration), () {
      keyboardIsVisible.value = visible;
    });
  }
}
