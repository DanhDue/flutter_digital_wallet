// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZenoHeaderBar extends StatelessWidget {
  const ZenoHeaderBar({
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
    return Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        InkWell(
          onTap: Get.back,
          child: Assets.images.icArrowLeft.svg(
            width: 36,
            height: 36,
            fit: .cover,
            colorFilter: .mode(context.appThemes.textGrey, .srcIn),
          ),
        ),
        Expanded(
          child: Center(child: Assets.images.icZenoTxt.image(width: 105, fit: .cover)),
        ),
        Visibility(
          visible: false,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: Assets.images.icBack.svg(width: 36, height: 36, fit: BoxFit.cover),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
