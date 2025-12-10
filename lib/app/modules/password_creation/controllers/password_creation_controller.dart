// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/utils/biometric_auth/biometric_authenticator.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:material_text_fields/utils/extensions.dart';

class PasswordCreationController extends BaseController {
  dynamic arguments = Get.arguments;

  final appConfigsRepository = Get.find<AppConfigsRepository>();
  late AppConfigurations? appConfigurations;

  final BiometricAuthenticator biometricAuthenticator = Get.find();
  late bool? biometricAuthIsNotSupported;
  final showBiometricLogin = false.obs;

  late final TextEditingController passwordTextEditingController;
  late final FocusNode passwordFocusNode;
  final passwordIsFocus = false.obs;
  String? password;
  final showPasswordClearIcon = false.obs;
  final obscurePassword = true.obs;
  final passError = "".obs;

  late final TextEditingController confirmPasswordTextEditingController;
  late final FocusNode confirmPasswordFocusNode;
  final confirmPasswordIsFocus = false.obs;
  String? confirmPassword;
  final showConfirmPasswordClearIcon = false.obs;
  final obscureConfirmPassword = true.obs;

  final authWithBiometric = false.obs;
  final policyIsAccepted = false.obs;
  final keyboardIsShown = false.obs;

  final passwordLengthIsError = PasswordStatus.none.obs;
  final passwordSimpleCharacterIsError = PasswordStatus.none.obs;
  final passwordSpecialCharacterIsError = PasswordStatus.none.obs;
  final passwordsAreNotSame = false.obs;
  final enablePassCreationBut = false.obs;

  final passStrength = PasswordStrength.none.obs;

  final keyboardIsDismiss = true.obs;

  final passwordAndWalletIsCreated = false.obs;

  static const int mediumStrengthPasswordLength = 8;
  static const int strongStrengthPasswordLength = 12;

  late final Rx<WalletResponseObject?> wallet = WalletResponseObject().obs;

  // Regex patterns
  static final _repeatedCharRegex = RegExp(r'^(\w)\1+$');
  static final _sequentialCharRegex = RegExp(r'^(.)\1{2,}$');
  static final _repeatingSequenceRegex = RegExp(r'(.)\1{2,}');

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    passwordTextEditingController = TextEditingController();
    passwordFocusNode = FocusNode();
    confirmPasswordTextEditingController = TextEditingController();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    _loadAppConfig();
    _handleFocusListener(
      focusNode: passwordFocusNode,
      isFocus: passwordIsFocus,
      showClearIcon: showPasswordClearIcon,
      otherFocusIsActive: confirmPasswordIsFocus,
      textValue: () => password,
      validate: _validatePassword,
    );
    _handleFocusListener(
      focusNode: confirmPasswordFocusNode,
      isFocus: confirmPasswordIsFocus,
      showClearIcon: showConfirmPasswordClearIcon,
      otherFocusIsActive: passwordIsFocus,
      textValue: () => confirmPassword,
      validate: _validatePassword,
    );
  }

  @override
  void onClose() {
    passwordTextEditingController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordTextEditingController.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  Future<void> _loadAppConfig() async {
    Fimber.d("_loadAppConfig()");
    appConfigurations =
        await appConfigsRepository.retrieveAppConfigurations() ?? AppConfigurations();
    checkBiometricAuthentication();
  }

  void _handleFocusListener({
    required FocusNode focusNode,
    required RxBool isFocus,
    required RxBool showClearIcon,
    required RxBool otherFocusIsActive,
    required String? Function() textValue,
    required VoidCallback validate,
  }) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isFocus.value = true;
        keyboardIsShown.value = true;
        if (textValue()?.isNotEmpty == true) showClearIcon.value = true;
      } else {
        validate();
        isFocus.value = false;
        Future.delayed(Duration(milliseconds: Constants.keyboardDismissDuration), () {
          if (otherFocusIsActive.value != true) {
            keyboardIsShown.value = false;
          }
        });
        showClearIcon.value = textValue()?.isNotEmpty == true;
      }
    });
  }

  void keyboardVisibilityChanged(bool visible) {
    keyboardIsDismiss.value = !visible;
    if (!visible) {
      if (StringExt(password)?.isNotBlank() == true) {
        passError.value = "";
        passwordsAreNotSame.value = password != confirmPassword;
      } else if (StringExt(confirmPassword)?.isNotBlank() == true) {
        passError.value = "fail";
      }
      _validateInputForm();
    }
  }

  void passwordTextChanged(String? password) {
    Fimber.d("passwordTextChanged(String? $password)");
    this.password = password;
    showPasswordClearIcon.value = true;
    passError.value = "";
    passwordsAreNotSame.value = false;
    passStrength.value = estimatePasswordSecureLevel(password);
    _checkPassLength(password);
    _checkPassSimpleCharacter(password);
    _checkPassSpecialCharacter(password);
  }

  void _checkPassLength(String? password) {
    passwordLengthIsError.value =
        (password?.length.isGreaterThan(7) == true) ? PasswordStatus.pass : PasswordStatus.fail;
  }

  void _checkPassSimpleCharacter(String? password) {
    if (password?.isNullOrEmpty() == true) {
      passwordSimpleCharacterIsError.value = PasswordStatus.fail;
      return;
    }
    if (password!.containsLowercase() && password.containsUppercase()) {
      passwordSimpleCharacterIsError.value = PasswordStatus.pass;
    } else {
      passwordSimpleCharacterIsError.value = PasswordStatus.fail;
    }
  }

  void _checkPassSpecialCharacter(String? password) {
    if (password?.isNullOrEmpty() == true) {
      passwordSpecialCharacterIsError.value = PasswordStatus.fail;
      return;
    }
    if (password!.containsDigit() && password.containsSpecialCharacter()) {
      passwordSpecialCharacterIsError.value = PasswordStatus.pass;
    } else {
      passwordSpecialCharacterIsError.value = PasswordStatus.fail;
    }
  }

  void clearPassword() {
    Fimber.d("clearPassword()");
    passwordTextEditingController.clear();
    password = '';
    showPasswordClearIcon.value = false;
    passError.value = "";
    enablePassCreationBut.value = false;
    passwordsAreNotSame.value = false;
    passStrength.value = PasswordStrength.none;
    passwordLengthIsError.value = PasswordStatus.none;
    passwordSimpleCharacterIsError.value = PasswordStatus.none;
    passwordSpecialCharacterIsError.value = PasswordStatus.none;
  }

  void clearConfirmPassword() {
    Fimber.d("clearConfirmPassword()");
    enablePassCreationBut.value = false;
    confirmPasswordTextEditingController.clear();
    confirmPassword = '';
    showConfirmPasswordClearIcon.value = false;
  }

  PasswordStrength estimatePasswordSecureLevel(String? password) {
    if (password == null || password.isEmpty) return PasswordStrength.none;
    if (password.length >= strongStrengthPasswordLength &&
        !_isSimplePassword(password) &&
        password.containsSpecialCharacter() &&
        password.containsDigit() &&
        password.containsLowercase() &&
        password.containsUppercase()) {
      return PasswordStrength.strong;
    } else if (password.length >= mediumStrengthPasswordLength &&
        (password.containsLowercase() || password.containsUppercase())) {
      return PasswordStrength.fair;
    } else {
      return PasswordStrength.weak;
    }
  }

  bool _isSimplePassword(String? password) {
    if (password == null || password.isEmpty) return true;
    final lowerPassword = password.toLowerCase();
    if (_repeatedCharRegex.hasMatch(lowerPassword)) return true; // e.g., "aaaaaa"
    if (_sequentialCharRegex.hasMatch(lowerPassword)) return true; // e.g., "1111"
    if (_repeatingSequenceRegex.hasMatch(lowerPassword)) return true; // e.g., "abc111def"

    const sequential = [
      'abcdefghijklmnopqrstuvwxyz',
      '0123456789',
      'qwertyuiop',
      'asdfghjkl',
      'zxcvbnm',
    ];
    for (final seq in sequential) {
      if (seq.contains(lowerPassword) || seq.split('').reversed.join().contains(lowerPassword)) {
        return true;
      }
    }
    return false;
  }

  void _validatePassword() {
    Fimber.d("_validatePassword()");
  }

  void toggleBiometric(bool enable) {
    Fimber.d("toggleBiometric(enable: $enable)");
    authWithBiometric.value = enable;
    appConfigurations = appConfigurations?.copyWith(isBiometricsLogin: enable);
    appConfigsRepository.saveAppConfigurations(appConfigurations);
  }

  void createPassword({bool fromOnboarding = false}) async {
    Fimber.d("createPassword()");
    enablePassCreationBut.value = false;
    appConfigurations = appConfigurations?.copyWith(localPasswords: password);
    if (fromOnboarding) {
      passwordAndWalletIsCreated.value = true;
      return;
    }
    await appConfigsRepository.saveAppConfigurations(appConfigurations);
    if ((arguments as String?).equalsIgnoreCase(Constants.ignoreGenNewWallet) != true) {
      Get.offNamed(
        Routes.WALLET_CREATION,
        arguments: {NavigationArguments.appConfigurations: appConfigurations},
      );
    } else {
      Get.offNamed(
        Routes.WALLET_IMPORT,
        arguments: {NavigationArguments.appConfigurations: appConfigurations},
      );
    }
  }

  void confirmPasswordTextChanged(String? confirmPassword) {
    Fimber.d("confirmPasswordTextChanged(String? $confirmPassword)");
    enablePassCreationBut.value = false;
    this.confirmPassword = confirmPassword;
    showConfirmPasswordClearIcon.value = true;
    passwordsAreNotSame.value = false;
    if (password.isNullOrEmpty()) {
      passError.value = "fail";
    }
  }

  @visibleForTesting
  Future<void> checkBiometricAuthentication() async {
    Fimber.d("checkBiometricAuthentication()");
    biometricAuthIsNotSupported = await biometricAuthenticator.deviceIsSupported();
    showBiometricLogin.value = biometricAuthIsNotSupported ?? false;
  }

  @visibleForTesting
  Future<void> handleBiometricLogin() async {
    Fimber.d("handleBiometricLogin()");
    final authenticated = await biometricAuthenticator.authenticateWithBiometrics(
      LocaleKeys.bimometricDescription.tr,
    );
    if (authenticated) Get.offAllNamed(Routes.HOME);
  }

  void updateConfig() {
    Fimber.d("updateConfig()");
    _loadAppConfig();
  }

  void _validateInputForm() {
    Fimber.d("_validateInputForm()");
    if (StringExt(password)?.isNotBlank() == true &&
        passwordLengthIsError.value == PasswordStatus.pass &&
        passwordSimpleCharacterIsError.value == PasswordStatus.pass &&
        passwordSpecialCharacterIsError.value == PasswordStatus.pass &&
        policyIsAccepted.value == true &&
        passwordsAreNotSame.value != true) {
      enablePassCreationBut.value = true;
    } else {
      enablePassCreationBut.value = false;
    }
  }

  void acceptPasswordPolicy(bool isAccepted) {
    Fimber.d("acceptPasswordPolicy(isAccepted: $isAccepted)");
    policyIsAccepted.value = isAccepted;
    _validateInputForm();
  }
}

enum PasswordStatus { none, fail, pass }

enum PasswordStrength { none, weak, fair, strong }
