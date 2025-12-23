// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:auto_size_text/auto_size_text.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends AppBar {
  Color? backGroundColor;
  BuildContext? context;

  CustomAppBar({
    super.key,
    required this.context,
    String? title,
    this.backGroundColor,
    bool? showHomeButton = false,
    List<Widget>? actions,
    VoidCallback? handleBackPress,
    bool shouldBeBack = true,
  }) : super(
         backgroundColor: backGroundColor ?? AppColors.mainGreen,
         elevation: 0,
         title: AutoSizeText(
           title ?? "",
           style: context?.appThemes.h2.copyWith(color: context.appThemes.appBar),
         ),
         centerTitle: true,
         automaticallyImplyLeading: false,
         leading: context != null && Navigator.canPop(context) && shouldBeBack
             ? IconButton(
                 onPressed: () {
                   Fimber.d("CustomAppBar.backPress()");
                   handleBackPress != null ? handleBackPress.call() : Get.back();
                 },
                 icon: Assets.images.icArrowLeft.svg(width: 24, height: 24),
               )
             : null,
         actions: [
           ...(actions ?? []),
           if (showHomeButton == true)
             IconButton(
               onPressed: () {
                 Get.offNamedUntil(Routes.HOME, (Route<dynamic> route) => false);
               },
               icon: Assets.images.icHome.svg(fit: .cover, width: 24, height: 24),
             ),
         ],
       );
}
