// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonHeaderBar extends StatelessWidget {
  const CommonHeaderBar({
    super.key,
    this.title,
    this.network,
    this.closePress,
    this.enableBackPress = true,
    this.backIcon,
    this.actionIcon,
    this.actions,
    this.showShadow = true,
    this.backPress,
  });

  final String? title;
  final String? network;
  final VoidCallback? closePress;
  final VoidCallback? backPress;
  final bool enableBackPress;
  final Widget? backIcon;
  final Widget? actionIcon;
  final List<Widget>? actions;
  final bool? showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: const .only(left: 12, top: 50, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: showShadow == true
            ? [
                BoxShadow(
                  color: context.appThemes.ink80.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                  spreadRadius: 4,
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: const .symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            Stack(
              alignment: .centerLeft,
              children: [
                Visibility(
                  visible: enableBackPress == true,
                  maintainSize: closePress != null,
                  maintainAnimation: true,
                  maintainState: true,
                  child: InkWell(
                    onTap: () {
                      if (backPress == null) {
                        Get.back();
                      }
                      backPress?.call();
                    },
                    child:
                        backIcon ?? Assets.images.icBack.svg(width: 36, height: 36, fit: .cover),
                  ),
                ),
                (actions != null && actions!.isNotEmpty)
                    ? Visibility(
                        visible: false,
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        child: Row(
                          mainAxisSize: .min,
                          crossAxisAlignment: .center,
                          children: actions!,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                mainAxisSize: .max,
                children: [
                  Text(
                    title ?? "",
                    style: context.appThemes.medium16.copyWith(color: context.appThemes.ink100),
                  ),
                  Visibility(
                    visible: network?.isNotEmpty == true,
                    child: Text(
                      network ?? "",
                      style: context.appThemes.regular12.copyWith(color: context.appThemes.ink60),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: .centerRight,
              children: [
                Visibility(
                  visible: closePress != null,
                  maintainSize: closePress == null && enableBackPress == true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: InkWell(
                    onTap: () => closePress?.call(),
                    child: Container(
                      width: 36,
                      height: 36,
                      padding: const .all(6),
                      child: Assets.images.icCloseRound.svg(fit: .cover),
                    ),
                  ),
                ),
                (actions != null && actions!.isNotEmpty)
                    ? Row(mainAxisSize: .min, crossAxisAlignment: .center, children: actions!)
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
