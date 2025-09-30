// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/good_log.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_themes.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppThemes extends ThemeExtension<AppThemes> with _$AppThemesTailorMixin {
  AppThemes({
    required this.bold12,
    required this.bold16,
    required this.regular16,
    required this.bold24,
    required this.medium24,
    required this.medium32,
    required this.medium16,
    required this.regular14,
    required this.regular20,
    required this.bold20,
    required this.regular10,
    required this.regular12,
    required this.medium14,
    required this.headline,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.paragraph,
    required this.subText,
    required this.subTexMedium,
    required this.smallTex,
    required this.paragraphSemiBold,
    required this.background,
    required this.appBar,
    required this.mainGreen,
    required this.smokyBlack,
    required this.palmLeaf,
    required this.apple,
    required this.dartmouthGreen,
    required this.textLightGrey,
    required this.textGrey,
    required this.black,
    required this.transparent,
    required this.textColor,
    required this.trueBlue,
    required this.white,
    required this.cultured,
    required this.ankeesBlue,
    required this.shinyShamrock,
    required this.silver,
    required this.red,
    required this.ink0,
    required this.ink40,
    required this.ink5,
    required this.blue15,
    required this.ink60,
    required this.ink100,
    required this.ink80,
    required this.green100,
    required this.ink20,
    required this.green10,
    required this.ink10,
    required this.bold14,
    required this.red100,
    required this.red0,
    required this.blue0,
    required this.blue5,
    required this.blue10,
    required this.blue20,
    required this.blue40,
    required this.blue60,
    required this.blue80,
    required this.blue100,
    required this.yellow5,
    required this.yellow100,
    required this.orange100,
    required this.green0,
  });

  static const bold14TextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const bold12TextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    decoration: TextDecoration.none,
  );

  static const bold16TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  static const regular14TextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const regular16TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  static const medium14TextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.7,
    decoration: TextDecoration.none,
  );

  static const medium24TextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33,
    decoration: TextDecoration.none,
  );

  static const medium32TextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  static const medium16TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  static const bold20TextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const bold24TextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.34,
    decoration: TextDecoration.none,
  );

  static const regular20TextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const regular12TextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    decoration: TextDecoration.none,
  );

  static const regular10TextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const headLineTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.6,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const h1TextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const h2TextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const h3TextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const paragraphTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const subTexTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const subTexMediumTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const smallTexTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  static const paragraphSemiBoldTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: 1.0,
    decoration: TextDecoration.none,
  );

  @override
  final TextStyle regular16;
  @override
  final TextStyle bold24;
  @override
  final TextStyle medium24;
  @override
  final TextStyle medium32;
  @override
  final TextStyle medium16;
  @override
  final TextStyle bold14;
  @override
  final TextStyle bold16;
  @override
  final TextStyle bold12;
  @override
  final TextStyle regular14;
  @override
  final TextStyle regular20;
  @override
  final TextStyle bold20;
  @override
  final TextStyle regular10;
  @override
  final TextStyle regular12;
  @override
  final TextStyle medium14;
  @override
  final TextStyle headline;
  @override
  final TextStyle h1;
  @override
  final TextStyle h2;
  @override
  final TextStyle h3;
  @override
  final TextStyle paragraph;
  @override
  final TextStyle subText;
  @override
  final TextStyle subTexMedium;
  @override
  final TextStyle smallTex;
  @override
  final TextStyle paragraphSemiBold;
  @override
  final Color background;
  @override
  final Color appBar;
  @override
  final Color mainGreen;
  @override
  final Color smokyBlack;
  @override
  final Color palmLeaf;
  @override
  final Color apple;
  @override
  final Color dartmouthGreen;
  @override
  final Color textLightGrey;
  @override
  final Color textGrey;
  @override
  final Color black;
  @override
  final Color transparent;
  @override
  final Color textColor;
  @override
  final Color trueBlue;
  @override
  final Color white;
  @override
  final Color cultured;
  @override
  final Color ankeesBlue;
  @override
  final Color shinyShamrock;
  @override
  final Color silver;
  @override
  final Color red;
  @override
  final Color ink0;
  @override
  final Color ink40;
  @override
  final Color ink5;
  @override
  final Color ink60;
  @override
  final Color ink100;
  @override
  final Color ink80;
  @override
  final Color green100;
  @override
  final Color ink20;
  @override
  final Color green10;
  @override
  final Color ink10;
  @override
  final Color red100;
  @override
  final Color red0;
  @override
  final Color blue0;
  @override
  final Color blue5;
  @override
  final Color blue10;
  @override
  final Color blue15;
  @override
  final Color blue20;
  @override
  final Color blue40;
  @override
  final Color blue60;
  @override
  final Color blue80;
  @override
  final Color blue100;
  @override
  final Color yellow5;
  @override
  final Color yellow100;
  @override
  final Color orange100;
  @override
  final Color green0;
}

final lightAppThemes = AppThemes(
  regular16: AppThemes.regular16TextStyle,
  bold24: AppThemes.bold24TextStyle,
  medium24: AppThemes.medium24TextStyle,
  medium32: AppThemes.medium32TextStyle,
  medium16: AppThemes.medium16TextStyle,
  bold14: AppThemes.bold14TextStyle,
  bold16: AppThemes.bold16TextStyle,
  bold12: AppThemes.bold12TextStyle,
  regular14: AppThemes.regular14TextStyle,
  regular20: AppThemes.regular20TextStyle,
  bold20: AppThemes.bold20TextStyle,
  regular12: AppThemes.regular12TextStyle,
  regular10: AppThemes.regular10TextStyle,
  medium14: AppThemes.medium14TextStyle,
  background: AppColors.white,
  appBar: AppColors.black,
  headline: AppThemes.headLineTextStyle,
  h1: AppThemes.h1TextStyle,
  h2: AppThemes.h2TextStyle,
  h3: AppThemes.h3TextStyle,
  paragraph: AppThemes.paragraphTextStyle,
  subText: AppThemes.subTexTextStyle,
  subTexMedium: AppThemes.subTexMediumTextStyle,
  smallTex: AppThemes.smallTexTextStyle,
  paragraphSemiBold: AppThemes.paragraphSemiBoldTextStyle,
  mainGreen: AppColors.mainGreen,
  smokyBlack: AppColors.smokyBlack,
  palmLeaf: AppColors.palmLeaf,
  apple: AppColors.apple,
  dartmouthGreen: AppColors.dartmouthGreen,
  textLightGrey: AppColors.textLightGrey,
  textGrey: AppColors.textGrey,
  black: AppColors.black,
  transparent: AppColors.transparent,
  textColor: AppColors.black,
  trueBlue: AppColors.trueBlue,
  white: AppColors.white,
  cultured: AppColors.cultured,
  ankeesBlue: AppColors.ankeesBlue,
  shinyShamrock: AppColors.shinyShamrock,
  silver: AppColors.silver,
  red: AppColors.red,
  ink0: AppColors.ink0,
  ink40: AppColors.ink40,
  ink5: AppColors.ink5,
  ink60: AppColors.ink60,
  ink100: AppColors.ink100,
  ink80: AppColors.ink80,
  green100: AppColors.green100,
  ink20: AppColors.ink20,
  green10: AppColors.green10,
  ink10: AppColors.ink10,
  red100: AppColors.red100,
  red0: AppColors.red0,
  blue0: AppColors.blue0,
  blue5: AppColors.blue5,
  blue10: AppColors.blue10,
  blue15: AppColors.blue15,
  blue20: AppColors.blue20,
  blue40: AppColors.blue40,
  blue60: AppColors.blue60,
  blue80: AppColors.blue80,
  blue100: AppColors.blue100,
  yellow5: AppColors.yellow5,
  yellow100: AppColors.yellow100,
  orange100: AppColors.orange100,
  green0: AppColors.green0,
);

final darkAppThemes = AppThemes(
  regular16: AppThemes.regular16TextStyle,
  bold24: AppThemes.bold24TextStyle,
  medium24: AppThemes.medium24TextStyle,
  medium32: AppThemes.medium32TextStyle,
  medium16: AppThemes.medium16TextStyle,
  bold14: AppThemes.bold14TextStyle,
  bold16: AppThemes.bold16TextStyle,
  bold12: AppThemes.bold12TextStyle,
  regular14: AppThemes.regular14TextStyle,
  regular20: AppThemes.regular20TextStyle,
  bold20: AppThemes.bold20TextStyle,
  regular12: AppThemes.regular12TextStyle,
  regular10: AppThemes.regular10TextStyle,
  medium14: AppThemes.medium14TextStyle,
  background: AppColors.black,
  appBar: AppColors.white,
  headline: AppThemes.headLineTextStyle,
  h1: AppThemes.h1TextStyle,
  h2: AppThemes.h2TextStyle,
  h3: AppThemes.h3TextStyle,
  paragraph: AppThemes.paragraphTextStyle,
  subText: AppThemes.subTexTextStyle,
  subTexMedium: AppThemes.subTexMediumTextStyle,
  smallTex: AppThemes.smallTexTextStyle,
  paragraphSemiBold: AppThemes.paragraphSemiBoldTextStyle,
  mainGreen: AppColors.mainGreen,
  smokyBlack: AppColors.smokyBlack,
  palmLeaf: AppColors.palmLeaf,
  apple: AppColors.apple,
  dartmouthGreen: AppColors.dartmouthGreen,
  textLightGrey: AppColors.textLightGrey,
  textGrey: AppColors.textGrey,
  black: AppColors.black,
  transparent: AppColors.transparent,
  textColor: AppColors.white,
  trueBlue: AppColors.trueBlue,
  white: AppColors.black,
  cultured: AppColors.cultured,
  ankeesBlue: AppColors.ankeesBlue,
  shinyShamrock: AppColors.shinyShamrock,
  silver: AppColors.silver,
  red: AppColors.red,
  ink0: AppColors.ink0,
  ink40: AppColors.ink40,
  ink5: AppColors.ink5,
  ink60: AppColors.ink60,
  ink100: AppColors.ink100,
  ink80: AppColors.ink80,
  green100: AppColors.green100,
  ink20: AppColors.ink20,
  green10: AppColors.green10,
  ink10: AppColors.ink10,
  red100: AppColors.red100,
  red0: AppColors.red0,
  blue0: AppColors.blue0,
  blue5: AppColors.blue5,
  blue10: AppColors.blue10,
  blue15: AppColors.blue15,
  blue20: AppColors.blue20,
  blue40: AppColors.blue40,
  blue60: AppColors.blue60,
  blue80: AppColors.blue80,
  blue100: AppColors.blue100,
  yellow5: AppColors.yellow5,
  yellow100: AppColors.yellow100,
  orange100: AppColors.orange100,
  green0: AppColors.green0,
);

final talkerTheme = TalkerScreenTheme(logColors: {GoodLog.getKey: const Color(0xff4CAF50)});

class GradientExtension {
  late BuildContext? context;
  late AppThemes? themeExtensions;

  static final GradientExtension _inst = GradientExtension._internal();

  GradientExtension._internal();

  factory GradientExtension(BuildContext context) {
    _inst.context = context;
    _inst.themeExtensions = context.appThemes;
    return _inst;
  }

  LinearGradient get headerGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      themeExtensions?.smokyBlack.withValues(alpha: 0.8) ?? AppColors.smokyBlack,
      themeExtensions?.palmLeaf.withValues(alpha: 0.24) ?? AppColors.palmLeaf,
    ],
  );

  LinearGradient get enableButtonGradient => LinearGradient(
    begin: const Alignment(-0.92, 0.19),
    end: const Alignment(-0.19, -0.27),
    colors: [
      themeExtensions?.apple ?? AppColors.apple,
      themeExtensions?.apple ?? AppColors.apple,
      themeExtensions?.dartmouthGreen ?? AppColors.apple,
      themeExtensions?.dartmouthGreen ?? AppColors.apple,
    ],
  );

  LinearGradient get disableButtonGradient => LinearGradient(
    colors: [
      themeExtensions?.textLightGrey ?? AppColors.textLightGrey,
      themeExtensions?.textLightGrey ?? AppColors.textLightGrey,
      themeExtensions?.textGrey ?? AppColors.textGrey,
      themeExtensions?.textGrey ?? AppColors.textGrey,
    ],
  );
}
