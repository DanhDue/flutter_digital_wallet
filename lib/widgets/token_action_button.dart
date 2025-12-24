// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokenActionButton extends StatelessWidget {
  const TokenActionButton({super.key, required this.icon, required this.title});

  final AssetGenImage icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        icon.image(width: 53, height: 80, fit: BoxFit.cover).paddingOnly(bottom: 6),
        Text(
          title,
          style: context.appThemes.bold14.copyWith(color: context.appThemes.greenVogue),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
