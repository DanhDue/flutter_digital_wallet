// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../controllers/mnemonic_description_controller.dart';

class MnemonicDescriptionView extends BaseView<MnemonicDescriptionController> {
  const MnemonicDescriptionView({super.key, this.getStarted, this.skip});

  final VoidCallback? getStarted;
  final VoidCallback? skip;

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
                      Assets.images.icVault.svg(fit: BoxFit.cover),
                      Text.rich(
                        TextSpan(
                          text: LocaleKeys.protectYourWalletDescriptionSegment1.tr,
                          style: context.appThemes.regular18.copyWith(
                            color: context.appThemes.ink60,
                          ),
                          children: [
                            TextSpan(
                              text: LocaleKeys.srp.tr,
                              style: context.appThemes.regular18.copyWith(
                                color: context.appThemes.trueBlue100,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _showSRPDescription(context),
                            ),
                            TextSpan(
                              text: LocaleKeys.protectYourWalletDescriptionSegment2.tr,
                              style: context.appThemes.regular18.copyWith(
                                color: context.appThemes.ink60,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(width: double.infinity, height: 1, color: context.appThemes.ink10),
                SizedBox(height: 12),
                IntrinsicHeight(
                  child: CustomUnfilledButton(
                    horizontalPadding: 16,
                    text: LocaleKeys.remindMeLater.tr,
                    subText: LocaleKeys.notRecommended.tr,
                    onPressed: () => skip?.call(),
                  ),
                ),
                SizedBox(height: 8),
                IntrinsicHeight(
                  child: CustomFilledButton(
                    horizontalPadding: 16,
                    text: LocaleKeys.txtContinue.tr,
                    onPressed: () => getStarted?.call(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showSRPDescription(BuildContext context) async {
    // showModalBottomSheet(
    //   context: context,
    //   useRootNavigator: true,
    //   backgroundColor: context.appThemes.transparent,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   builder:
    //       (context) => Padding(
    //         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: Wrap(
    //           children: [
    //             SecretRecoveryPhraseDescriptionView(
    //               bindingCreator: () => SecretRecoveryPhraseDescriptionBinding(),
    //             ),
    //           ],
    //         ),
    //       ),
    //   routeSettings: RouteSettings(name: Routes.SECRET_RECOVERY_PHRASE_DESCRIPTION),
    //   isScrollControlled: true,
    // );
  }
}
