// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataLayout extends StatelessWidget {
  const NoDataLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        Assets.images.icHasNoData.image(width: 96, height: 96, fit: .cover),
        const SizedBox(height: 12),
        Text(
          LocaleKeys.oops.tr,
          style: context.appThemes.bold20.copyWith(color: context.appThemes.black),
        ),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.noDataMessage.tr,
          style: context.appThemes.h3.copyWith(color: context.appThemes.textGrey),
        ),
      ],
    );
  }
}
