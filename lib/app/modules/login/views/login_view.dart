// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:async';

import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/base/widgets/input_text.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController(), permanent: false);

  late StreamSubscription<bool> keyboardSubscription;

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
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 36),
                Center(child: Assets.images.icZenoTxt.image(width: 136, fit: BoxFit.cover)),
                SizedBox(height: 24),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 46),
                        Assets.images.icSecureServer.svg(width: 146, fit: BoxFit.cover),
                        SizedBox(height: 24),
                        Text(
                          LocaleKeys.welcomeback.tr,
                          style: context.appThemes.bold20.copyWith(
                            color: context.appThemes.ink100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: InputText(
                              controller: controller.passwordTextEditingController,
                              focusNode: controller.passwordFocusNode,
                              onChanged: (value) => controller.passwordTextChanged(value),
                              status:
                                  controller.passwordIsFocus.value
                                      ? InputTextStatus.focus
                                      : controller.passError.value.isNotBlank == true
                                      ? InputTextStatus.error
                                      : InputTextStatus.normal,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: controller.obscurePassword.value,
                              labelText: LocaleKeys.password.tr,
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
                                  controller.password.isNotBlank
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
                              onFieldSubmitted: (value) => controller.checkPassword(),
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.passError.value.isNotBlank == true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(
                                    controller.passError.value,
                                    style: context.appThemes.paragraphSemiBold.copyWith(
                                      color: AppColors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Obx(
                                  () => CustomFilledButton(
                                    onPressed: () {
                                      if (controller.enableUnlockButton.value != true) return;
                                      controller.checkPassword();
                                    },
                                    backgroundColor:
                                        controller.enableUnlockButton.value
                                            ? context.appThemes.trueBlue
                                            : context.appThemes.blue15,
                                    text: LocaleKeys.unlock.tr,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.showBiometricLogin.value,
                                child: InkWell(
                                  onTap: () => controller.handleBiometricLogin(),
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.only(left: 16),
                                    child: Assets.images.icFaceId.svg(
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        context.appThemes.textGrey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
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
                  () => Visibility(
                    visible: !controller.keyboardIsVisible.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            LocaleKeys.cannotLoginGuide.tr,
                            style: context.appThemes.regular14.copyWith(
                              color: context.appThemes.ink60,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 12),
                        InkWell(
                          onTap: () async {
                            final needToReimportWallets = await Get.dialog(
                              _reimportWalletWarningDialog(context),
                            );
                            Fimber.d("needToReimportWallets: ");
                            if (needToReimportWallets) controller.reimportWallets();
                          },
                          child: Text(
                            LocaleKeys.reimportWallets.tr,
                            style: context.appThemes.medium14.copyWith(
                              color: context.appThemes.trueBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _reimportWalletWarningDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: context.appThemes.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.icIllusWarning.svg(width: 48, height: 48, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              LocaleKeys.reimportWalletWarningTitle.tr,
              style: context.appThemes.bold16.copyWith(color: context.appThemes.ink100),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              LocaleKeys.reimportDesOne.tr,
              style: context.appThemes.regular12.copyWith(color: context.appThemes.ink80),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: LocaleKeys.reimportDesTwoFirstSegment.tr,
                style: context.appThemes.regular12.copyWith(color: context.appThemes.ink80),
                children: <TextSpan>[
                  TextSpan(
                    text: LocaleKeys.reimportDesTwoSecondSegment.tr,
                    style: context.appThemes.bold12.copyWith(color: context.appThemes.ink100),
                  ),
                  TextSpan(
                    text: LocaleKeys.reimportDesTwoThirdSegment.tr,
                    style: context.appThemes.regular12.copyWith(color: context.appThemes.ink80),
                  ),
                  TextSpan(
                    text: LocaleKeys.reimportDesTwoFourthSegment.tr,
                    style: context.appThemes.bold12.copyWith(color: context.appThemes.ink100),
                  ),
                  TextSpan(
                    text: LocaleKeys.reimportDesTwoFifthSegment.tr,
                    style: context.appThemes.regular12.copyWith(color: context.appThemes.ink80),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Get.back(result: true);
                },
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: WidgetStateProperty.all(context.appThemes.trueBlue),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: context.appThemes.trueBlue),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),
                  child: Text(
                    LocaleKeys.continueRemoving.tr,
                    style: context.appThemes.medium14.copyWith(color: context.appThemes.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: WidgetStateProperty.all(context.appThemes.transparent),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(color: context.appThemes.transparent, width: 0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),
                  child: Text(
                    LocaleKeys.cancel.tr,
                    style: context.appThemes.medium14.copyWith(color: context.appThemes.trueBlue),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
