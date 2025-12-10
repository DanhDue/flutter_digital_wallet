// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:animated_item/animated_item.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_confirmation/bindings/mnemonic_confirmation_binding.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_confirmation/views/mnemonic_confirmation_view.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_creation/bindings/mnemonic_creation_binding.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_creation/views/mnemonic_creation_view.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_description/bindings/mnemonic_description_binding.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_description/views/mnemonic_description_view.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_warning/bindings/mnemonic_warning_binding.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_warning/views/mnemonic_warning_view.dart';
import 'package:d3_wallet/app/modules/password_creation/bindings/password_creation_binding.dart';
import 'package:d3_wallet/app/modules/password_creation/views/onboarding_password_creation_view.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/keep_alive_widget.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../controllers/onboard_controller.dart';

class OnboardView extends StatefulHookWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final controller = Get.put(OnboardController(), permanent: false);

  static const int passwordCreationPageIndex = 0;
  static const int secureWalletPageIndex = 1;
  static const int mnemonicDescriptionPageIndex = 2;
  static const int mnemonicWarningPageIndex = 3;
  static const int mnemonicVerificationPageIndex = 4;
  static const int mnemonicConfirmationPageIndex = 5;

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(
      keepPage: true,
      initialPage: passwordCreationPageIndex,
    );

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    (controller.currentPage.value == passwordCreationPageIndex ||
                            controller.currentPage.value == mnemonicVerificationPageIndex)
                        ? InkWell(
                          onTap: () {
                            controller.currentPage.value == passwordCreationPageIndex
                                ? Get.back()
                                : controller.jumpToPage(mnemonicDescriptionPageIndex);
                          },
                          child: Assets.images.icBack.svg(
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          child: Assets.images.icBack.svg(
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                    Expanded(
                      child: Center(
                        child: Assets.images.icZenoTxt.image(width: 105, fit: BoxFit.cover),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Assets.images.icBack.svg(width: 36, height: 36, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            _createHeaderProgressBar(context),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AnimatedPage(
                    index: passwordCreationPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      child: OnboardingPasswordCreationView(
                        passwordAndWalletAreCreated: (data) {
                          controller.updateCreatedAppConfigurations(data.$1, data.$2);
                          controller.jumpToPage(secureWalletPageIndex);
                        },
                      ),
                      bindingCreator: () => PasswordCreationBinding(),
                    ),
                  ),
                  AnimatedPage(
                    index: secureWalletPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicDescriptionBinding(),
                      child: MnemonicDescriptionView(
                        skip: () => controller.createWalletAndSaveAppConfigurations(toHome: true),
                        getStarted: () => controller.jumpToPage(mnemonicDescriptionPageIndex),
                      ),
                    ),
                  ),
                  AnimatedPage(
                    index: mnemonicDescriptionPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicWarningBinding(),
                      child: MnemonicWarningView(
                        showMnemonic: () => controller.jumpToPage(mnemonicWarningPageIndex),
                      ),
                    ),
                  ),
                  AnimatedPage(
                    index: mnemonicWarningPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicCreationBinding(),
                      child: Obx(
                        () => MnemonicCreationView(
                          createdWallet: controller.wallet.value,
                          goToMnemonicConfirmation: () {
                            controller.mnemonicIsGenereated();
                            controller.jumpToPage(mnemonicVerificationPageIndex);
                          },
                        ),
                      ),
                    ),
                  ),
                  AnimatedPage(
                    index: mnemonicVerificationPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicConfirmationBinding(),
                      child: Obx(
                        () => MnemonicConfirmationView(
                          createdWallet: controller.wallet.value,
                          mnemonicIsVerified:
                              (isVerified) =>
                                  controller.updateMnemonicIsVerified(isVerified ?? false),
                          finish: () => Get.offAllNamed(Routes.WALLET_CREATION_SUCCESSFULLY),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoading.value == true) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  // EasyLoading.show(dismissOnTap: false);
                  SmartDialog.showLoading(msg: "");
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  // EasyLoading.dismiss();
                  SmartDialog.dismiss();
                });
              }
              if (controller.currentPage.value != 0) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  _pageController.jumpToPage(controller.currentPage.value);
                });
              }
              if (controller.passwordAndWalletIsCreated.value) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  controller.jumpToPage(mnemonicDescriptionPageIndex);
                  controller.passwordAndWalletIsCreated.value = false;
                });
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  _createHeaderProgressBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => Container(
                      height: 1,
                      color:
                          controller.passwordIsCreated.value
                              ? context.appThemes.green100
                              : context.appThemes.ink40,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => Container(
                      height: 1,
                      color:
                          controller.mnemonicIsShown.value
                              ? context.appThemes.green100
                              : context.appThemes.ink40,
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      controller.passwordIsCreated.value
                          ? Assets.images.icStepSuccessed.svg(
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                          )
                          : Assets.images.icStepOne.svg(width: 16, height: 16, fit: BoxFit.cover),
                      SizedBox(height: 4),
                      Text(
                        LocaleKeys.createPassword.tr,
                        style: context.appThemes.regular10.copyWith(
                          color:
                              controller.passwordIsCreated.value
                                  ? context.appThemes.green100
                                  : context.appThemes.blue60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      controller.mnemonicIsShown.value
                          ? Assets.images.icStepSuccessed.svg(
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                          )
                          : ((controller.currentPage.value == secureWalletPageIndex ||
                                  controller.currentPage.value == mnemonicDescriptionPageIndex)
                              ? Assets.images.icStepTwo.image(
                                width: 16,
                                height: 16,
                                fit: BoxFit.cover,
                              )
                              : Assets.images.icDisableStepTwo.svg(
                                width: 16,
                                height: 16,
                                fit: BoxFit.cover,
                              )),
                      SizedBox(height: 4),
                      Text(
                        LocaleKeys.secureWalletStep.tr,
                        style: context.appThemes.regular10.copyWith(
                          color:
                              controller.mnemonicIsShown.value
                                  ? context.appThemes.green100
                                  : context.appThemes.blue60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      controller.mnemonicIsVerified.value
                          ? Assets.images.icStepSuccessed.svg(
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                          )
                          : (controller.currentPage.value == mnemonicVerificationPageIndex
                              ? Assets.images.icStepThree.image(
                                width: 16,
                                height: 16,
                                fit: BoxFit.cover,
                              )
                              : Assets.images.icDisableStepThree.svg(
                                width: 16,
                                height: 16,
                                fit: BoxFit.cover,
                              )),
                      SizedBox(height: 4),
                      Text(
                        LocaleKeys.confirmSRPStep.tr,
                        style: context.appThemes.regular10.copyWith(
                          color:
                              controller.mnemonicIsVerified.value
                                  ? context.appThemes.green100
                                  : context.appThemes.blue60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
