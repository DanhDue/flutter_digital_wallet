// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    super.key,
    this.onPressed,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.horizontalPadding,
    this.horizontalTextPadding,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? horizontalTextPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(horizontal: horizontalPadding ?? 16),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: WidgetStateProperty.all(backgroundColor ?? context.appThemes.blue100),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                width: borderColor != null ? 1 : 0,
                color: borderColor ?? context.appThemes.blue100,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalTextPadding ?? 8, vertical: 0),
          child: Text(
            text ?? "",
            style: context.appThemes.medium14.copyWith(
              color: textColor ?? context.appThemes.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
