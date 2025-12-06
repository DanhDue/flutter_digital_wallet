// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/intro/intro/views/first_intro_page.dart';
import 'package:d3_wallet/app/modules/intro/intro/views/second_intro_page.dart';
import 'package:d3_wallet/app/modules/intro/intro/views/third_intro_page.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/intro_controller.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  // ignore: unused_field
  int _currentPageIndex = 0;
  static const _pageNumber = 3;

  final controller = Get.put(IntroController(), permanent: false);
  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: _pageNumber, vsync: this);
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 6),
            InkWell(
              onTap:
                  () => {
                    // controller.skip()
                  },
              child: Assets.images.android12splashLight.image(height: 128, fit: BoxFit.cover),
            ),
            SizedBox(height: 32),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    controller: _pageViewController,
                    onPageChanged: _handlePageViewChanged,
                    children: [FirstIntroPage(), SecondIntroPage(), ThirdIntroPage()],
                  ),
                  SmoothPageIndicator(
                    controller: _pageViewController,
                    count: _pageNumber,
                    effect: WormEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      spacing: 8,
                      radius: 16,
                      dotColor: context.appThemes.ink10,
                      activeDotColor: context.appThemes.trueBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomUnfilledButton(
                  onPressed: () {
                    Fimber.d("restore a exists wallet.");
                    // controller.importWallet();
                  },
                  horizontalPadding: 16,
                  borderRadius: 30,
                  verticalPadding: 8,
                  borderColor: context.appThemes.trueBlue,
                  text: LocaleKeys.alreadyHaveAWallet.tr,
                ),
                CustomFilledButton(
                  onPressed: () {
                    Fimber.d("create a new wallet");
                    // controller.createNewWallet();
                  },
                  horizontalPadding: 16,
                  borderRadius: 30,
                  verticalPadding: 8,
                  text: LocaleKeys.createANewWallet.tr,
                ),
              ],
            ),
            SizedBox(height: 26),
          ],
        ),
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  // ignore: unused_element
  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
