// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/home/constants/nav_ids.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomBotNavBar extends StatelessWidget {
  const CustomBotNavBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = context.appThemes.trueBlue;
    final inactiveColor = context.appThemes.boldGrey;
    final backgroundColor = context.appThemes.white;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: context.appThemes.ink40.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 23, top: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: Assets.images.icWalletLine,
                activeIcon: Assets.images.icWallet,
                label: LocaleKeys.navMyWallet.tr,
                isActive: currentIndex == NavIds.wallet,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(NavIds.wallet),
              ),
              _NavItem(
                icon: Assets.images.icGlobe,
                activeIcon: Assets.images.icGlobe,
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
                icon: Assets.images.icMarket,
                activeIcon: Assets.images.icMarket,
                label: LocaleKeys.navTrends.tr,
                isActive: currentIndex == NavIds.trends,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(NavIds.trends),
              ),
              _NavItem(
                icon: Assets.images.icSettingsLine,
                activeIcon: Assets.images.icSettingsLine,
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

  final dynamic icon; // Can be SvgGenImage, AssetGenImage, IconData
  final dynamic activeIcon; // Can be SvgGenImage, AssetGenImage, IconData
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIcon(color, icon, activeIcon, isActive),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: isActive
                      ? context.appThemes.bold12.copyWith(color: color)
                      : context.appThemes.regular12.copyWith(color: color),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 13),
              ],
            ),
            if (isActive)
              Assets.images.icSelectedBotTabIndicator.image(fit: BoxFit.cover, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color color, dynamic icon, dynamic activeIcon, bool isActive) {
    final asset = isActive ? activeIcon : icon;
    if (asset is SvgGenImage) {
      return asset.svg(
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else if (asset is AssetGenImage) {
      return asset.image(width: 24, height: 24, color: color);
    } else {
      return Icon(isActive ? activeIcon : icon, color: color, size: 24);
    }
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
        offset: const Offset(0, -16), // Elevate the button
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
