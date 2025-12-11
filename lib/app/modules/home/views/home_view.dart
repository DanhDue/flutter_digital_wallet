// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/my_wallets/bindings/my_wallets_binding.dart';
import 'package:d3_wallet/app/modules/my_wallets/views/my_wallets_view.dart';
import 'package:d3_wallet/app/modules/profile/views/profile_view.dart';
import 'package:d3_wallet/app/modules/qr_scanning/views/qr_scanning_view.dart';
import 'package:d3_wallet/app/modules/transactions/views/transactions_view.dart';
import 'package:d3_wallet/app/modules/trends/views/trends_view.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentTabIndex.value,
          children: [
            _TabPage(
              navKey: controller.myWalletsNavKey,
              child: MyWalletsView(bindingCreator: () => MyWalletsBinding()),
            ),
            _TabPage(navKey: controller.transactionsNavKey, child: TransactionsView()),
            _TabPage(navKey: controller.qrScanningNavKey, child: QRScanningView()),
            _TabPage(navKey: controller.trendsNavKey, child: TrendsView()),
            _TabPage(navKey: controller.profileNavKey, child: ProfileView()),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentTabIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          backgroundColor: context.appThemes.white,
          selectedItemColor: context.appThemes.mainGreen,
          unselectedItemColor: context.appThemes.ink40,
          selectedLabelStyle: context.appThemes.medium14,
          unselectedLabelStyle: context.appThemes.regular12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz_outlined),
              activeIcon: Icon(Icons.swap_horiz),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_outlined),
              activeIcon: Icon(Icons.qr_code_scanner),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_outlined),
              activeIcon: Icon(Icons.trending_up),
              label: 'Trends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

/// A tab page with its own Navigator for nested navigation
class _TabPage extends StatelessWidget {
  const _TabPage({required this.navKey, required this.child});

  final GlobalKey<NavigatorState> navKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Navigator(
      key: navKey,
      onGenerateRoute:
          (settings) => MaterialPageRoute(
            builder:
                (context) => PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) async {
                    if (didPop) return;

                    // Check if this navigator can pop
                    if (navKey.currentState?.canPop() == true) {
                      navKey.currentState?.pop();
                      return;
                    }

                    // At root - handle double-back-to-exit
                    final shouldExit = await controller.handleBackPress();
                    if (shouldExit) {
                      SystemNavigator.pop();
                    }
                  },
                  child: child,
                ),
            settings: settings,
          ),
    );
  }
}
