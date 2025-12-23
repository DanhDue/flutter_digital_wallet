// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:get/get.dart';

class FirstIntroPage extends StatelessWidget {
  @Preview(group: 'Intro', name: 'First Intro Page')
  const FirstIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          Container(
            padding: const .symmetric(horizontal: 32),
            child: Text(
              LocaleKeys.welcomeToZenoWallet.tr,
              style: context.appThemes.bold20.copyWith(color: context.appThemes.ink100),
              textAlign: .center,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const .symmetric(horizontal: 30),
            child: Text(
              LocaleKeys.firstIntroDescription.tr,
              style: context.appThemes.regular16.copyWith(color: context.appThemes.ink60),
              textAlign: .center,
            ),
          ),
          const SizedBox(height: 46),
          Assets.images.icFirstIntro.image(fit: .cover),
        ],
      ),
    );
  }
}
