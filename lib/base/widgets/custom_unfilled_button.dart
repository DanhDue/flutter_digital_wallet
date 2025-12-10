// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

class CustomUnfilledButton extends StatelessWidget {
  const CustomUnfilledButton({
    super.key,
    this.onPressed,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.textColor,
    this.horizontalPadding,
    this.horizontalTextPadding,
    this.subText,
    this.startIcon,
    this.endIcon,
    this.verticalPadding,
    this.verticalTextPadding,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? horizontalTextPadding;
  final double? verticalTextPadding;
  final String? subText;
  final Widget? startIcon;
  final Widget? endIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: horizontalPadding ?? 0,
        vertical: verticalPadding ?? 0,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? context.appThemes.transparent,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 6),
              side: BorderSide(
                width: borderColor != null ? 1 : 0,
                color: borderColor ?? context.appThemes.transparent,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalTextPadding ?? 8,
            vertical: verticalTextPadding ?? 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: startIcon != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [startIcon ?? SizedBox.shrink(), SizedBox(width: 2)],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text ?? "",
                      style: context.appThemes.medium16.copyWith(
                        color: textColor ?? context.appThemes.trueBlue100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Visibility(
                      visible: subText?.isNotEmpty == true,
                      child: Text(
                        subText ?? "",
                        style: context.appThemes.medium16.copyWith(color: context.appThemes.ink60),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: endIcon != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [SizedBox(width: 2), endIcon ?? SizedBox.shrink()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
