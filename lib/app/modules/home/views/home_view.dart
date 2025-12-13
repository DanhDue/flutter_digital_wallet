// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/app/modules/home/navs/profile_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/qr_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/transactions_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/trends_nav.dart';
import 'package:d3_wallet/app/modules/home/navs/wallet_nav.dart';
import 'package:d3_wallet/base/base_view.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
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
        body: Obx(
          () => IndexedStack(
            index: HomeController.to.currentTabIndex.value,
            children: const [WalletNav(), TransactionsNav(), QRNav(), TrendsNav(), ProfileNav()],
          ),
        ),
        bottomNavigationBar: Obx(
          () => _CustomBottomNavBar(
            currentIndex: HomeController.to.currentTabIndex.value,
            onTap: HomeController.to.changeTab,
          ),
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
                label: LocaleKeys.navMyWallet.tr,
                isActive: currentIndex == NavIds.wallet,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(NavIds.wallet),
              ),
              _NavItem(
                icon: Icons.swap_horiz_outlined,
                activeIcon: Icons.swap_horiz,
                label: LocaleKeys.navTransactions.tr,
                isActive: currentIndex == NavIds.transactions,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(NavIds.transactions),
              ),
              // Center elevated QR Scanner button
              _CenterNavItem(
                icon: Icons.qr_code_scanner,
                isActive: currentIndex == NavIds.qr,
                activeColor: activeColor,
                onTap: () => onTap(NavIds.qr),
              ),
              _NavItem(
                icon: Icons.trending_up_outlined,
                activeIcon: Icons.trending_up,
                label: LocaleKeys.navTrends.tr,
                isActive: currentIndex == NavIds.trends,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(NavIds.trends),
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: LocaleKeys.navSettings.tr,
                isActive: currentIndex == NavIds.profile,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(NavIds.profile),
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
