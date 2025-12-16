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

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(
      keepPage: true,
      initialPage: OnboardPageIndex.passwordCreationPageIndex,
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
                    (controller.currentPage.value == OnboardPageIndex.passwordCreationPageIndex ||
                            controller.currentPage.value ==
                                OnboardPageIndex.mnemonicConfirmationPageIndex ||
                            controller.currentPage.value == OnboardPageIndex.secureWalletPageIndex)
                        ? InkWell(
                          onTap: () {
                            (controller.currentPage.value ==
                                        OnboardPageIndex.passwordCreationPageIndex ||
                                    controller.currentPage.value ==
                                        OnboardPageIndex.secureWalletPageIndex)
                                ? Get.back()
                                : {
                                  controller.shouldBeConfirmMnemonic.value = false,
                                  controller.jumpToPage(
                                    OnboardPageIndex.mnemonicCreationPageIndex,
                                  ),
                                };
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
                    index: OnboardPageIndex.passwordCreationPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      child: OnboardingPasswordCreationView(
                        passwordAndWalletAreCreated: (data) {
                          controller.updateCreatedAppConfigurations(data);
                          controller.jumpToPage(OnboardPageIndex.secureWalletPageIndex);
                        },
                      ),
                      bindingCreator: () => PasswordCreationBinding(),
                    ),
                  ),
                  AnimatedPage(
                    index: OnboardPageIndex.secureWalletPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicDescriptionBinding(),
                      child: MnemonicDescriptionView(
                        skip: () => controller.createWalletAndSaveAppConfigurations(toHome: true),
                        getStarted:
                            () => controller.jumpToPage(
                              OnboardPageIndex.mnemonicDescriptionPageIndex,
                            ),
                      ),
                    ),
                  ),
                  AnimatedPage(
                    index: OnboardPageIndex.mnemonicDescriptionPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicWarningBinding(),
                      child: MnemonicWarningView(
                        showMnemonic: () => controller.createWalletAndSaveAppConfigurations(),
                      ),
                    ),
                  ),
                  AnimatedPage(
                    index: OnboardPageIndex.mnemonicCreationPageIndex,
                    controller: _pageController,
                    effect: FadeEffect(opacity: 1),
                    child: KeepAliveWidget(
                      bindingCreator: () => MnemonicCreationBinding(),
                      child: Obx(
                        () => MnemonicCreationView(
                          createdWallet: controller.wallet.value,
                          goToMnemonicConfirmation: () {
                            controller.mnemonicIsGenereated();
                            controller.jumpToPage(OnboardPageIndex.mnemonicConfirmationPageIndex);
                          },
                        ),
                      ),
                    ),
                  ),
                  AnimatedPage(
                    index: OnboardPageIndex.mnemonicConfirmationPageIndex,
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
                  SmartDialog.showLoading(msg: "");
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
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
                  controller.jumpToPage(OnboardPageIndex.mnemonicDescriptionPageIndex);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 1, child: Container()),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => Container(
                      height: 1.5,
                      color:
                          controller.passwordIsCreated.value
                              ? context.appThemes.techBlue
                              : context.appThemes.ink10,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => Container(
                      height: 1.5,
                      color:
                          controller.shouldBeConfirmMnemonic.value
                              ? context.appThemes.techBlue
                              : context.appThemes.ink10,
                    ),
                  ),
                ),
                SizedBox(width: 16),
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
                          ? Assets.images.icStepOneIsDone.svg(
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          )
                          : Assets.images.icStepOneIsRunning.svg(
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                      SizedBox(height: 4),
                      Text(
                        LocaleKeys.createPassword.tr,
                        style: context.appThemes.regular10.copyWith(
                          color:
                              controller.passwordIsCreated.value
                                  ? context.appThemes.techBlue
                                  : context.appThemes.ink60,
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
                      controller.shouldBeConfirmMnemonic.value
                          ? Assets.images.icStepTwoIsDone.svg(
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          )
                          : ((controller.currentPage.value ==
                                      OnboardPageIndex.secureWalletPageIndex ||
                                  controller.currentPage.value ==
                                      OnboardPageIndex.mnemonicDescriptionPageIndex ||
                                  controller.currentPage.value ==
                                      OnboardPageIndex.mnemonicCreationPageIndex)
                              ? Assets.images.icStepTwoIsRunning.svg(
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              )
                              : Assets.images.icStepTwoIsWaiting.svg(
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              )),
                      SizedBox(height: 4),
                      Text(
                        LocaleKeys.secureWalletStep.tr,
                        style: context.appThemes.regular10.copyWith(
                          color:
                              controller.shouldBeConfirmMnemonic.value
                                  ? context.appThemes.techBlue
                                  : context.appThemes.ink60,
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
                          ? Assets.images.icStepThreeIsDone.svg(
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          )
                          : (controller.currentPage.value ==
                                  OnboardPageIndex.mnemonicConfirmationPageIndex
                              ? Assets.images.icStepThreeIsRunning.svg(
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              )
                              : Assets.images.icStepThreeIsWaiting.svg(
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              )),
                      SizedBox(height: 4),
                      Text(
                        LocaleKeys.confirmSRPStep.tr,
                        style: context.appThemes.regular10.copyWith(
                          color:
                              controller.currentPage.value ==
                                      OnboardPageIndex.mnemonicConfirmationPageIndex
                                  ? context.appThemes.techBlue
                                  : context.appThemes.ink60,
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
