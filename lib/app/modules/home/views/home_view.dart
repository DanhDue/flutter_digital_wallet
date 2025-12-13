// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/home/navs/profile_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/qr_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/transactions_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/trends_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/wallet_nav.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/base/widgets/custom_bot_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Call the controller's back press handler
        await controller.handleBackPress();
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: false,
          child: Obx(
            () => IndexedStack(
              index: HomeController.to.currentTabIndex.value,
              children: const [WalletNav(), TransactionsNav(), QRNav(), TrendsNav(), ProfileNav()],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => CustomBotNavBar(
            currentIndex: HomeController.to.currentTabIndex.value,
            onTap: HomeController.to.changeTab,
          ),
        ),
      ),
    );
  }
}
