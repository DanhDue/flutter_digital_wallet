// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:animated_visibility/animated_visibility.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Assets.lotties.airplane.lottie(width: 220, fit: BoxFit.contain),
              Obx(
                () => AnimatedVisibility(
                  visible: controller.liveChatBotIsShown.value,
                  enter: fadeIn() + scaleIn(),
                  exit: fadeOut() + scaleOut(),
                  enterDuration: const Duration(milliseconds: 500),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Assets.lotties.liveChatbot.lottie(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        animate: controller.liveChatBotIsDancing.value,
                        repeat: true,
                        backgroundLoading: true,
                      ),
                      Assets.lotties.confetti.lottie(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        animate: controller.liveChatBotIsDancing.value,
                        repeat: true,
                        backgroundLoading: true,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => AnimatedVisibility(
                  visible: controller.liveChatBotIsShown.value,
                  enter: fadeIn() + scaleIn(),
                  exit: fadeOut() + scaleOut(),
                  enterDuration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Assets.lotties.digitalWallet.lottie(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      animate: controller.liveChatBotIsDancing.value,
                      repeat: true,
                      backgroundLoading: true,
                    ),
                  ),
                ),
              ),
              Assets.lotties.aiIntelligence.lottie(
                width: double.infinity,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.aiSubmarine.lottie(
                width: double.infinity,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.cryptoAnimation.lottie(
                width: double.infinity,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.cryptoCenter.lottie(
                width: double.infinity,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.digitalWallet.lottie(
                width: 320,
                height: 320,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.sandyLoading.lottie(
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.touristsOnTheRoad.lottie(
                width: double.infinity,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              Assets.lotties.trailLoading.lottie(
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                animate: true,
                repeat: true,
                backgroundLoading: true,
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.TALKER),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('View Logs', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
