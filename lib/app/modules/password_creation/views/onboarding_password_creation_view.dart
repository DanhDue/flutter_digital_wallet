// Copyright (c) 2025, one of the UniCloud projects. All rights reserved.

// coverage:ignore-file

import 'dart:async';

import 'package:d3_wallet/app/modules/password_creation/controllers/password_creation_controller.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/base/widgets/input_text.dart';
import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/utils/extensions.dart';

class OnboardingPasswordCreationView extends StatefulHookWidget {
  const OnboardingPasswordCreationView({super.key, this.passwordAndWalletAreCreated});

  final ValueChanged<(WalletResponseObject?, AppConfigurations?)>? passwordAndWalletAreCreated;

  @override
  State<OnboardingPasswordCreationView> createState() => _OnboardingPasswordCreationViewState();
}

class _OnboardingPasswordCreationViewState extends State<OnboardingPasswordCreationView> {
  final controller = Get.put(PasswordCreationController(), permanent: false);

  late StreamSubscription<bool> keyboardSubscription;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    Fimber.d('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      Fimber.d('Keyboard visibility update. Is visible: $visible');
      controller.keyboardVisibilityChanged(visible);
    });
  }

  @override
  void dispose() {
    super.dispose();
    keyboardSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = useScrollController();
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.passwordCreationTitle.tr,
                          style: context.appThemes.bold24.copyWith(
                            color: context.appThemes.ink100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        LocaleKeys.passwordDesc.tr,
                        style: context.appThemes.regular14.copyWith(
                          color: context.appThemes.ink60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      Obx(
                        () => InputText(
                          controller: controller.passwordTextEditingController,
                          focusNode: controller.passwordFocusNode,
                          onChanged: (value) => controller.passwordTextChanged(value),
                          status:
                              controller.passwordIsFocus.value
                                  ? InputTextStatus.focus
                                  : controller.passError.value.isNotBlank() == true
                                  ? InputTextStatus.error
                                  : InputTextStatus.normal,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: controller.obscurePassword.value,
                          labelText: LocaleKeys.newPassword.tr,
                          hintText: LocaleKeys.enterTextPlease.tr,
                          enableInteractiveSelection: false,
                          suffixIcon:
                              controller.showPasswordClearIcon.value == true
                                  ? InkWell(
                                    onTap: () => controller.clearPassword(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 24,
                                        top: 12,
                                        bottom: 12,
                                        right: 4,
                                      ),
                                      child: Assets.images.icClear.svg(),
                                    ),
                                  )
                                  : null,
                          showPrefixIconsDivider: controller.showPasswordClearIcon.value,
                          secondSuffixIcon:
                              controller.password.isNotBlank()
                                  ? (controller.obscurePassword.value == true
                                      ? Assets.images.icVisibility.svg(
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      )
                                      : Assets.images.icInvisibility.svg(
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ))
                                  : SizedBox.shrink(),
                          onSecondSuffixIconTap:
                              () =>
                                  controller.obscurePassword.value =
                                      !controller.obscurePassword.value,
                          onFieldSubmitted: (v) {
                            FocusScope.of(
                              context,
                            ).requestFocus(controller.confirmPasswordFocusNode);
                          },
                          maxLength: 21,
                          counterText: "",
                          counterStyle: context.appThemes.regular10.copyWith(fontSize: 0),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 4),
                          Obx(
                            () => Visibility(
                              visible:
                                  controller.passError.value.isNotBlank() &&
                                  controller.password.isNullOrEmpty(),
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                                child: Text(
                                  LocaleKeys.passwordIsEmtpyError.tr,
                                  style: context.appThemes.regular12.copyWith(
                                    color: context.appThemes.red100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.passStrength.value != PasswordStrength.none,
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      LocaleKeys.passwordStrength.tr,
                                      style: context.appThemes.regular12.copyWith(
                                        color: context.appThemes.ink40,
                                      ),
                                    ),
                                    Text(
                                      controller.passStrength.value == PasswordStrength.fair
                                          ? LocaleKeys.passwordIsFair.tr
                                          : (controller.passStrength.value == PasswordStrength.weak
                                              ? LocaleKeys.passwordIsWeak.tr
                                              : LocaleKeys.passwordIsExcellent.tr),
                                      style: context.appThemes.regular12.copyWith(
                                        color:
                                            controller.passStrength.value == PasswordStrength.fair
                                                ? context.appThemes.yellow100
                                                : (controller.passStrength.value ==
                                                        PasswordStrength.weak
                                                    ? context.appThemes.red100
                                                    : context.appThemes.green100),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Obx(
                        () => InputText(
                          controller: controller.confirmPasswordTextEditingController,
                          focusNode: controller.confirmPasswordFocusNode,
                          onChanged: (value) => controller.confirmPasswordTextChanged(value),
                          status:
                              controller.confirmPasswordIsFocus.value
                                  ? InputTextStatus.focus
                                  : (controller.passwordsAreNotSame.value == true
                                      ? InputTextStatus.error
                                      : InputTextStatus.normal),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.obscureConfirmPassword.value,
                          labelText: LocaleKeys.confirmPassword.tr,
                          hintText: LocaleKeys.reEnterPass.tr,
                          enableInteractiveSelection: false,
                          suffixIcon:
                              controller.showConfirmPasswordClearIcon.value == true
                                  ? InkWell(
                                    onTap: () => controller.clearConfirmPassword(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 24,
                                        top: 12,
                                        bottom: 12,
                                        right: 4,
                                      ),
                                      child: Assets.images.icClear.svg(),
                                    ),
                                  )
                                  : null,
                          showPrefixIconsDivider: controller.showConfirmPasswordClearIcon.value,
                          secondSuffixIcon:
                              controller.confirmPassword.isNotBlank()
                                  ? (controller.obscureConfirmPassword.value == true
                                      ? Assets.images.icVisibility.svg(
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      )
                                      : Assets.images.icInvisibility.svg(
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ))
                                  : SizedBox.shrink(),
                          onSecondSuffixIconTap:
                              () =>
                                  controller.obscureConfirmPassword.value =
                                      !controller.obscureConfirmPassword.value,
                          onFieldSubmitted: (v) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.passwordsAreNotSame.value == true,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  LocaleKeys.passwordsAreNotSameError.tr,
                                  style: context.appThemes.regular12.copyWith(
                                    color: context.appThemes.red100,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        LocaleKeys.passwordsRequests.tr,
                        style: context.appThemes.medium14.copyWith(
                          color: context.appThemes.ink100,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => _createPasswordRule(
                          context,
                          text: LocaleKeys.passwordLengthRequest.tr,
                          status: controller.passwordLengthIsError.value,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => _createPasswordRule(
                          context,
                          text: LocaleKeys.passwordCharactersRequest.tr,
                          status: controller.passwordSimpleCharacterIsError.value,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => _createPasswordRule(
                          context,
                          text: LocaleKeys.passwordSpecialCharacterRequest.tr,
                          status: controller.passwordSpecialCharacterIsError.value,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.txtOpenWithBiometric.tr,
                              style: context.appThemes.regular14.copyWith(
                                color: context.appThemes.ink100,
                              ),
                            ),
                          ),
                          Obx(
                            () => CupertinoSwitch(
                              activeTrackColor: context.appThemes.green100,
                              thumbColor: context.appThemes.white,
                              inactiveTrackColor: context.appThemes.black.withValues(alpha: 0.12),
                              value: controller.authWithBiometric.value,
                              onChanged:
                                  (value) => {
                                    controller.toggleBiometric(
                                      !controller.authWithBiometric.value,
                                    ),
                                  },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      InkWell(
                        onTap:
                            () => controller.acceptPasswordPolicy(
                              !controller.policyIsAccepted.value,
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(
                              () =>
                                  controller.policyIsAccepted.value
                                      ? Assets.images.icCheckedBox.svg(
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      )
                                      : Assets.images.icUncheckedBox.svg(
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: LocaleKeys.passwordPolicy.tr,
                                  style: context.appThemes.regular14.copyWith(
                                    color: context.appThemes.ink100,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: LocaleKeys.learnMore.tr,
                                      style: context.appThemes.regular14.copyWith(
                                        color: context.appThemes.blue100,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () => Fimber.d("See more about"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => CustomFilledButton(
                  horizontalPadding: 16,
                  onPressed: () {
                    if (controller.enablePassCreationBut.value != true) return;
                    controller.createPassword(fromOnboarding: true);
                  },
                  backgroundColor:
                      controller.enablePassCreationBut.value
                          ? context.appThemes.blue100
                          : context.appThemes.blue15,
                  text: LocaleKeys.createPassword.tr,
                ),
              ),
              Obx(() {
                if (controller.isLoading.value == true) {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    // EasyLoading.show();
                    SmartDialog.showLoading(msg: "");
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    // EasyLoading.dismiss();
                    SmartDialog.dismiss();
                  });
                }
                if (controller.keyboardIsDismiss.value) {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    Future.delayed(Duration(milliseconds: Constants.keyboardDismissDuration), () {
                      _scrollUp();
                    });
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    Future.delayed(Duration(milliseconds: Constants.keyboardDismissDuration), () {
                      _scrollDown();
                    });
                  });
                }
                if (controller.passwordAndWalletIsCreated.value) {
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    Future.delayed(Duration(milliseconds: Constants.keyboardDismissDuration), () {
                      widget.passwordAndWalletAreCreated?.call((
                        controller.wallet.value,
                        controller.appConfigurations,
                      ));
                    });
                  });
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollDown() {
    if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0) {
      double targetOffset = 110.0;
      if (targetOffset > _scrollController.position.maxScrollExtent) {
        targetOffset = _scrollController.position.maxScrollExtent;
      }
      _scrollController.animateTo(
        targetOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
      return;
    }
  }

  void _scrollUp() {
    if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0) {
      double targetOffset = 0.0;
      if (targetOffset > _scrollController.position.maxScrollExtent) {
        targetOffset = _scrollController.position.maxScrollExtent;
      }
      _scrollController.animateTo(
        targetOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
      return;
    }
  }

  _createPasswordRule(
    BuildContext context, {
    String? text,
    PasswordStatus? status = PasswordStatus.none,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        status == PasswordStatus.pass
            ? Assets.images.icCheckCircle.svg(width: 24, height: 24, fit: BoxFit.cover)
            : (status == PasswordStatus.fail
                ? Assets.images.icErrorCheckCircle.svg(width: 24, height: 24, fit: BoxFit.cover)
                : Assets.images.icUncheckCircle.svg(width: 24, height: 24, fit: BoxFit.cover)),
        SizedBox(width: 8),
        Flexible(
          child: Text(
            text ?? "",
            style: context.appThemes.regular14.copyWith(color: context.appThemes.ink100),
          ),
        ),
      ],
    );
  }
}
