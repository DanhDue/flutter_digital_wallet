// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

class CommingSoonWidget extends StatelessWidget {
  const CommingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      height: .infinity,
      padding: const .symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .max,
        children: [
          Assets.images.icZenoTxt.image(width: 105, height: 100),
          const SizedBox(height: 48),
          Expanded(
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .max,
              children: [
                Text(
                  "LocaleKeys.commingSoon.tr",
                  style: context.appThemes.bold24.copyWith(color: context.appThemes.ink100),
                ),
                const SizedBox(height: 16),
                Text(
                  "LocaleKeys.commingSoonDescription.tr",
                  style: context.appThemes.regular16.copyWith(color: context.appThemes.ink60),
                ),
                const SizedBox(height: 48),
                Assets.images.icRocketLaunch.svg(fit: .cover),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
