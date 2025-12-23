// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, this.msg});

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IntrinsicWidth(
          child: Container(
            padding: const .all(16),
            decoration: BoxDecoration(
              color: context.appThemes.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: .center,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Assets.lotties.sandyLoading.lottie(
                  width: 120,
                  height: 120,
                  fit: .cover,
                  animate: true,
                  repeat: true,
                  backgroundLoading: true,
                ),
                Visibility(
                  visible: msg != null && msg!.isNotEmpty,
                  child: Column(
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        msg ?? LocaleKeys.processing.tr,
                        style: context.appThemes.regular12.copyWith(
                          color: context.appThemes.ink80,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
