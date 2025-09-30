// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:animated_visibility/animated_visibility.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

import '../controllers/splash_controller.dart';

class SplashView extends BaseView<SplashController> {
  SplashView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedVisibility(
            visible: controller.liveChatBotIsShown.value,
            enter: fadeIn() + scaleIn(),
            exit: fadeOut() + scaleOut(),
            enterDuration: Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RepaintBoundary(
                    child: Assets.lotties.digitalWallet.lottie(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      animate: controller.liveChatBotIsDancing.value,
                      repeat: true,
                      backgroundLoading: true,
                    ),
                  ),
                  OffsetText(
                    mode: AnimationMode.reverse,
                    text: LocaleKeys.digitalWallet.tr,
                    duration: const Duration(milliseconds: 500),
                    type: AnimationType.letter,
                    slideType: SlideAnimationType.leftRight,
                    textStyle: context.appThemes.bold24,
                  ),
                  SizedBox(height: 136),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
