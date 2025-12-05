// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

import '../controllers/start_controller.dart';

class StartView extends BaseView<StartController> {
  StartView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    LocaleKeys.zenoWallet.tr.toUpperCase(),
                    style: context.appThemes.bold24.copyWith(
                      color: context.appThemes.black,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 14),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 68),
                      RepaintBoundary(
                        child: Assets.lotties.cryptoAnimation.lottie(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          animate: true,
                          repeat: true,
                          backgroundLoading: true,
                        ),
                      ),
                      SizedBox(height: 92),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.secureCryptoWalletTitle.tr,
                          style: context.appThemes.bold24.copyWith(
                            color: context.appThemes.black,
                            fontSize: 38,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.manageDigitalAssets.tr,
                          style: context.appThemes.regular20.copyWith(
                            color: context.appThemes.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
            SliderButton(
              action: () async {
                return false;
              },
              label: Text(
                LocaleKeys.swipeToGetStarted.tr,
                style: context.appThemes.bold16.copyWith(color: context.appThemes.red100),
              ),
              alignLabel: Get.locale == AppLocales.vnVI ? Alignment(0.3, 0) : Alignment(0.6, 0),
              icon: Assets.images.icArrowRight.svg(),
              width: 251,
              height: 64,
              buttonSize: 50,
              buttonColor: context.appThemes.white,
              backgroundColor: context.appThemes.trueBlue,
              highlightedColor: context.appThemes.orange100,
              baseColor: context.appThemes.white,
            ),
          ],
        ),
      ),
    );
  }
}
