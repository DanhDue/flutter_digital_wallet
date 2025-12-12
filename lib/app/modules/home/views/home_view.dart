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
        () => _CustomBottomNavBar(
          currentIndex: controller.currentTabIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}

/// Custom Bottom Navigation Bar with elevated center button
class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = context.appThemes.mainGreen;
    final inactiveColor = context.appThemes.ink40;
    final backgroundColor = context.appThemes.white;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: context.appThemes.ink20.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.account_balance_wallet_outlined,
                activeIcon: Icons.account_balance_wallet,
                label: 'Ví của tôi',
                isActive: currentIndex == 0,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.swap_horiz_outlined,
                activeIcon: Icons.swap_horiz,
                label: 'Giao dịch',
                isActive: currentIndex == 1,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(1),
              ),
              // Center elevated QR Scanner button
              _CenterNavItem(
                icon: Icons.qr_code_scanner,
                isActive: currentIndex == 2,
                activeColor: activeColor,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: Icons.trending_up_outlined,
                activeIcon: Icons.trending_up,
                label: 'Xu hướng',
                isActive: currentIndex == 3,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(3),
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: 'Cài đặt',
                isActive: currentIndex == 4,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Regular navigation item
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isActive ? activeIcon : icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.appThemes.regular10.copyWith(color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Center elevated navigation item (QR Scanner)
class _CenterNavItem extends StatelessWidget {
  const _CenterNavItem({
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.translate(
        offset: const Offset(0, -12), // Elevate the button
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: activeColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: activeColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: context.appThemes.white, size: 28),
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
