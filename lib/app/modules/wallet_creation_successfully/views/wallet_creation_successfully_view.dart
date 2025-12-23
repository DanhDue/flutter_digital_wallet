// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import 'package:d3_wallet/generated/locales.g.dart';
import '../controllers/wallet_creation_successfully_controller.dart';

class WalletCreationSuccessfullyView extends BaseView<WalletCreationSuccessfullyController> {
  const WalletCreationSuccessfullyView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            Assets.images.icHighFiveRafiki.svg(fit: .cover),
            const SizedBox(height: 24),
            Text(
              LocaleKeys.secureRecoveryPhraseVerified.tr,
              style: context.appThemes.bold20.copyWith(color: context.appThemes.trueBlue100),
              textAlign: .center,
            ),
            const SizedBox(height: 16),
            Text(
              LocaleKeys.walletCreationSuccessMessage.tr,
              style: context.appThemes.regular16.copyWith(color: context.appThemes.trueBlue100),
              textAlign: .center,
            ),
            const SizedBox(height: 24),
            CustomFilledButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
              borderRadius: 8,
              verticalPadding: 8,
              text: LocaleKeys.letsGo.tr,
            ),
            const SizedBox(height: 68),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
