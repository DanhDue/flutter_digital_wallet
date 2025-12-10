// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/onboard/mnemonic_confirmation/controllers/mnemonic_confirmation_controller.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MnemonicConfirmationView extends StatefulHookWidget {
  const MnemonicConfirmationView({
    super.key,
    this.createdWallet,
    this.mnemonicIsVerified,
    this.finish,
  });

  final WalletResponseObject? createdWallet;

  final ValueChanged<bool?>? mnemonicIsVerified;

  final VoidCallback? finish;

  @override
  State<MnemonicConfirmationView> createState() => _MnemonicConfirmationViewState();
}

class _MnemonicConfirmationViewState extends State<MnemonicConfirmationView> {
  final controller = Get.put(MnemonicConfirmationController(), permanent: false);

  @override
  void initState() {
    super.initState();
    controller.setupInputs(widget.createdWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
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
                          LocaleKeys.confirmSecretRecoveryPhraseTitle.tr,
                          style: context.appThemes.bold24.copyWith(
                            color: context.appThemes.ink100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        LocaleKeys.confirmSecretRecoveryPhraseDescription.tr,
                        style: context.appThemes.regular14.copyWith(
                          color: context.appThemes.ink60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      _buildSecretRecoveryPhrase(context),
                      SizedBox(height: 24),
                      Stack(
                        children: [
                          _buildHiddenMnemonicWords(context),
                          Obx(
                            () => Visibility(
                              visible: controller.mnemonicIsFailure.value,
                              child: _buildErrorMessage(context),
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
                    onPressed: () async {
                      await controller.updateBackupState();
                      widget.finish?.call();
                    },
                    text: LocaleKeys.finish.tr,
                    backgroundColor:
                        (controller.wallet.value?.mnemonics?.isNotBlank() == true &&
                                controller.mnemonicIsVerified.value)
                            ? context.appThemes.trueBlue100
                            : context.appThemes.trueBlue40,
                  ),
                ),
              ],
            ),
            Obx(() {
              if (controller.mnemonicIsVerified.value) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  widget.mnemonicIsVerified?.call(true);
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  widget.mnemonicIsVerified?.call(false);
                });
              }
              if (controller.isLoading.value == true) {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  SmartDialog.showLoading(msg: "");
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  SmartDialog.dismiss();
                });
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  _buildSecretRecoveryPhrase(BuildContext context) {
    Fimber.d("_buildSecretRecoveryPhrase()");
    return Column(
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 12,
              childAspectRatio: 4.28,
            ),
            itemCount: controller.allWords.length,
            itemBuilder: (context, index) {
              Fimber.d("shownTexts.index: $index");
              return InkWell(
                onTap: () {
                  if (controller.allWords[index]?.isHidden != true) return;
                  controller.updateFocussedIndex(index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
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
                        ),
                      ],
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          alignment: Alignment.centerLeft,
                          decoration:
                              controller.allWords[index]?.isHidden != true
                                  ? BoxDecoration(
                                    color: context.appThemes.ink5,
                                    borderRadius: BorderRadius.circular(4),
                                  )
                                  : DottedDecoration(
                                    shape: Shape.box,
                                    borderRadius: BorderRadius.circular(4),
                                    color:
                                        index == controller.focusedIndex.value
                                            ? context.appThemes.trueBlue100
                                            : context.appThemes.ink10,
                                    dash: [2, 2],
                                  ),
                          child: Text(
                            controller.allWords[index]?.enterWord ?? "",
                            style: context.appThemes.regular14.copyWith(
                              color: context.appThemes.ink60,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildHiddenMnemonicWords(BuildContext context) {
    Fimber.d("_buildSecretRecoveryPhrase()");
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: context.appThemes.transparent),
            color: context.appThemes.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3.42,
              ),
              itemCount: controller.hiddenWordIndices.length,
              itemBuilder: (context, index) {
                Fimber.d("shownTexts.index: ");
                return InkWell(
                  onTap: () {
                    Fimber.d("word is selected: ${controller.hiddenWordIndices[index]}.");
                    controller.hiddenWordIsSelected(controller.hiddenWordIndices[index], index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: context.appThemes.ink5,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              controller.filledWords[controller.hiddenWordIndices[index]] ?? "",
                              style: context.appThemes.regular14.copyWith(
                                color: context.appThemes.ink60,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildErrorMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.appThemes.red0,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.appThemes.red100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icWarning.svg(
            width: 24,
            height: 24,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(context.appThemes.ink40, BlendMode.srcATop),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.incorrectSecretRecoveryPhrase.tr,
                style: context.appThemes.medium14.copyWith(color: context.appThemes.ink80),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2),
              Text(
                LocaleKeys.incorrectSecretRecoveryPhraseDescription.tr,
                style: context.appThemes.regular12.copyWith(color: context.appThemes.ink60),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
