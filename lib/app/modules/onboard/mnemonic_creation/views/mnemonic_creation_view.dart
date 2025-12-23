// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:animated_item/animated_item.dart';
import 'package:d3_wallet/app/modules/onboard/mnemonic_creation/controllers/mnemonic_creation_controller.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/base/widgets/expandable_page_view/expandable_page_view.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class MnemonicCreationView extends StatefulHookWidget {
  const MnemonicCreationView({super.key, this.goToMnemonicConfirmation, this.createdWallet});

  final WalletResponseObject? createdWallet;
  final VoidCallback? goToMnemonicConfirmation;

  @override
  State<MnemonicCreationView> createState() => _MnemonicCreationViewState();
}

class _MnemonicCreationViewState extends State<MnemonicCreationView> {
  final controller = Get.put(MnemonicCreationController(), permanent: false);

  @override
  void initState() {
    super.initState();
    controller.setInputs(widget.createdWallet);
  }

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(keepPage: true, initialPage: 0);
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.writeDownSecretRecoveryPhrase.tr,
                          style: context.appThemes.bold24.copyWith(
                            color: context.appThemes.ink100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        LocaleKeys.secretRecoveryPhraseDescription.tr,
                        style: context.appThemes.regular14.copyWith(
                          color: context.appThemes.ink60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ExpandablePageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          AnimatedPage(
                            index: 0,
                            controller: _pageController,
                            effect: FadeEffect(opacity: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _createGuideUILayouts(
                                  context,
                                  viewSecretRecoveryPhrase: () =>
                                      controller.generateSecretRecoveryPhrase(),
                                ),
                              ],
                            ),
                          ),
                          AnimatedPage(
                            index: 1,
                            controller: _pageController,
                            effect: FadeEffect(opacity: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [_buildSecretRecoveryPhrase(context)],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(width: double.infinity, height: 1, color: context.appThemes.ink10),
                SizedBox(height: 12),
                Obx(
                  () => CustomFilledButton(
                    horizontalPadding: 16,
                    onPressed: () {
                      if (!controller.secretRecoveryPhraseIsGenerated.value) return;
                      widget.goToMnemonicConfirmation?.call();
                    },
                    text: LocaleKeys.txtContinue.tr,
                    backgroundColor:
                        (controller.wallet.value?.mnemonics?.isNotBlank() == true &&
                            controller.secretRecoveryPhraseIsGenerated.value)
                        ? context.appThemes.trueBlue100
                        : context.appThemes.trueBlue40,
                  ),
                ),
              ],
            ),
            Obx(() {
              if (controller.secretRecoveryPhraseIsGenerated.value) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  _pageController.jumpToPage(1);
                });
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  _createGuideUILayouts(BuildContext context, {VoidCallback? viewSecretRecoveryPhrase}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: context.appThemes.ink10),
            color: context.appThemes.ink5,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.icVisibility.svg(width: 24, height: 24, fit: BoxFit.cover),
              SizedBox(height: 16),
              Text(
                LocaleKeys.tapToRevealSecretRecoveryPhrase.tr,
                style: context.appThemes.medium14.copyWith(color: context.appThemes.ink100),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                LocaleKeys.securityAlertMessage.tr,
                style: context.appThemes.regular14.copyWith(color: context.appThemes.ink80),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              IntrinsicWidth(
                child: CustomUnfilledButton(
                  verticalPadding: 0,
                  verticalTextPadding: 0,
                  borderColor: context.appThemes.trueBlue100,
                  text: LocaleKeys.viewPhrase.tr,
                  onPressed: () => viewSecretRecoveryPhrase?.call(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSecretRecoveryPhrase(BuildContext context) {
    Fimber.d("_buildSecretRecoveryPhrase()");
    if (controller.wallet.value?.mnemonics?.isNotBlank() == true) {
      final words = controller.wallet.value?.mnemonics?.split(" ");
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: context.appThemes.ink10),
              color: context.appThemes.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              semanticChildCount: words?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 12,
                childAspectRatio: 4.28,
              ),
              itemCount: words?.length ?? 0,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Visibility(
                            visible: false,
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: Text(
                              "12. ",
                              style: context.appThemes.regular14.copyWith(
                                color: context.appThemes.ink100,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            index > 9 ? "${index + 1}." : "${index + 1}. ",
                            style: context.appThemes.regular14.copyWith(
                              color: context.appThemes.ink100,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: context.appThemes.ink5,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          words?[index] ?? "",
                          style: context.appThemes.regular14.copyWith(
                            color: context.appThemes.ink60,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 12),
          IntrinsicWidth(
            child: CustomUnfilledButton(
              startIcon: Assets.images.icCopyLine.svg(
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(context.appThemes.trueBlue100, BlendMode.srcIn),
              ),
              text: LocaleKeys.copyToClipboardAction.tr,
              borderColor: context.appThemes.trueBlue100,
              horizontalPadding: 12,
              verticalPadding: 0,
              verticalTextPadding: 0,
              onPressed: () async {
                Fimber.d("copy mnemonics to the clipboard");
                await Clipboard.setData(
                  ClipboardData(text: controller.wallet.value?.mnemonics ?? ""),
                );
                Fimber.d("copied mnemonics: ${controller.wallet.value?.mnemonics ?? ""}");
                if (GetPlatform.isIOS) {
                  SmartDialog.showToast(
                    LocaleKeys.copiedToClipboard.tr,
                    displayTime: ToastDuration.LENGTH_SHORT,
                  );
                }
              },
            ),
          ),
        ],
      );
    } else {
      return Text(
        LocaleKeys.commonErrorMessage.tr,
        style: context.appThemes.h3,
        textAlign: TextAlign.center,
      );
    }
  }
}
