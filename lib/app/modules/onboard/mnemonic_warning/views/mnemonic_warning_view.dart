// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mnemonic_warning_controller.dart';

class MnemonicWarningView extends BaseView<MnemonicWarningController> {
  const MnemonicWarningView({super.key, this.showMnemonic});

  final VoidCallback? showMnemonic;

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Assets.images.icLockBig.svg(fit: BoxFit.cover),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.secureYourWallet.tr,
                          style: context.appThemes.bold24.copyWith(
                            color: context.appThemes.ink100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.secureYourWalletsPart1.tr,
                              style: context.appThemes.regular18.copyWith(
                                color: context.appThemes.ink100,
                              ),
                            ),
                            TextSpan(
                              text: LocaleKeys.secretRecoveryPhrase.tr,
                              style: context.appThemes.bold18.copyWith(
                                color: context.appThemes.trueBlue,
                              ),
                            ),
                            TextSpan(
                              text: LocaleKeys.secureYourWalletsPart2.tr,
                              style: context.appThemes.regular18.copyWith(
                                color: context.appThemes.ink100,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Assets.images.icInformation.svg(fit: BoxFit.cover),
                          SizedBox(width: 8),
                          Text(
                            LocaleKeys.whyIsThisImportant.tr,
                            style: context.appThemes.bold18.copyWith(
                              color: context.appThemes.trueBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Card(
                        color: Colors.white,
                        elevation: 8,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(width: 0.5, color: context.appThemes.blue0),
                        ),
                        shadowColor: context.appThemes.white,
                        surfaceTintColor: context.appThemes.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                LocaleKeys.manual.tr,
                                style: context.appThemes.bold20.copyWith(
                                  color: context.appThemes.ink100,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 16),
                              Text(
                                LocaleKeys.securityLevelVeryStrong.tr,
                                style: context.appThemes.bold16.copyWith(
                                  color: context.appThemes.ink80,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 8,
                                    decoration: BoxDecoration(color: context.appThemes.trueBlue),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    width: 56,
                                    height: 8,
                                    decoration: BoxDecoration(color: context.appThemes.trueBlue),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    width: 56,
                                    height: 8,
                                    decoration: BoxDecoration(color: context.appThemes.trueBlue),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                LocaleKeys.writeSRPOnPaperDescription.tr,
                                style: context.appThemes.regular16.copyWith(
                                  color: context.appThemes.ink60,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                LocaleKeys.riskAre.tr,
                                style: context.appThemes.bold16.copyWith(
                                  color: context.appThemes.ink80,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    " • ",
                                    style: context.appThemes.regular16.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.youLoseIt.tr,
                                      style: context.appThemes.regular16.copyWith(
                                        color: context.appThemes.ink60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    " • ",
                                    style: context.appThemes.regular16.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.youForgetWhereYouPutIt.tr,
                                      style: context.appThemes.regular16.copyWith(
                                        color: context.appThemes.ink60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    " • ",
                                    style: context.appThemes.regular16.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.someoneFindsIt.tr,
                                      style: context.appThemes.regular16.copyWith(
                                        color: context.appThemes.ink60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                LocaleKeys.otherOptionsNoPaper.tr,
                                style: context.appThemes.bold16.copyWith(
                                  color: context.appThemes.ink80,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    " • ",
                                    style: context.appThemes.regular16.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.storeInBankVault.tr,
                                      style: context.appThemes.regular16.copyWith(
                                        color: context.appThemes.ink60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    " • ",
                                    style: context.appThemes.regular16.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.storeInASafe.tr,
                                      style: context.appThemes.regular16.copyWith(
                                        color: context.appThemes.ink60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    " • ",
                                    style: context.appThemes.regular16.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.storeInMultipleSecretPlaces.tr,
                                      style: context.appThemes.regular16.copyWith(
                                        color: context.appThemes.ink60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).paddingAll(16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomFilledButton(
              horizontalPadding: 16,
              text: LocaleKeys.txtContinue.tr,
              onPressed: () => showMnemonic?.call(),
            ),
          ],
        ),
      ),
    );
  }
}
