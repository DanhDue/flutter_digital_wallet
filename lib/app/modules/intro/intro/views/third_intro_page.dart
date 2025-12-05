// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdIntroPage extends StatelessWidget {
  const ThirdIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              LocaleKeys.thirdIntroTitle.tr,
              style: context.appThemes.bold20.copyWith(color: context.appThemes.ink100),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              LocaleKeys.thirdIntroDescription.tr,
              style: context.appThemes.regular16.copyWith(color: context.appThemes.ink60),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 46),
          Assets.images.icThirdIntro.image(fit: BoxFit.cover),
        ],
      ),
    );
  }
}
