// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/good_log.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_themes.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppThemes extends ThemeExtension<AppThemes> with _$AppThemesTailorMixin {
  AppThemes({
    // TextStyles
    required this.headline,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.paragraph,
    required this.paragraphSemiBold,
    required this.subText,
    required this.subTexMedium,
    required this.smallTex,

    // Legacy TextStyles (Weight/Size)
    required this.bold24,
    required this.bold20,
    required this.bold18,
    required this.bold16,
    required this.bold14,
    required this.bold12,
    required this.medium32,
    required this.medium24,
    required this.medium18,
    required this.medium16,
    required this.medium14,
    required this.regular20,
    required this.regular18,
    required this.regular16,
    required this.regular14,
    required this.regular12,
    required this.regular10,

    // Colors
    // Neutrals
    required this.background,
    required this.appBar,
    required this.white,
    required this.black,
    required this.transparent,
    required this.textColor,
    required this.textGrey,
    required this.textLightGrey,
    required this.smokyBlack,
    required this.cultured,
    required this.silver,
    required this.gentleGray,
    required this.boldGrey,

    // Gold Series
    required this.rusticRoseGold,

    // Ink Series
    required this.ink0,
    required this.ink5,
    required this.ink10,
    required this.ink20,
    required this.ink40,
    required this.ink60,
    required this.ink80,
    required this.ink100,

    // Green Series
    required this.green0,
    required this.green5,
    required this.green10,
    required this.green15,
    required this.green20,
    required this.green40,
    required this.green60,
    required this.green80,
    required this.green100,
    required this.mainGreen,
    required this.darkGreen,
    required this.secondGreen,
    required this.palmLeaf,
    required this.dartmouthGreen,
    required this.apple,
    required this.shinyShamrock,
    required this.honeydew,
    required this.antiFlashWhite,
    required this.greenVogue0,
    required this.greenVogue5,
    required this.greenVogue10,
    required this.greenVogue15,
    required this.greenVogue20,
    required this.greenVogue25,
    required this.greenVogue30,
    required this.greenVogue35,
    required this.greenVogue40,
    required this.greenVogue45,
    required this.greenVogue50,
    required this.greenVogue55,
    required this.greenVogue60,
    required this.greenVogue65,
    required this.greenVogue70,
    required this.greenVogue75,
    required this.greenVogue80,
    required this.greenVogue85,
    required this.greenVogue90,
    required this.greenVogue95,
    required this.greenVogue100,
    required this.greenVogue,

    // Blue Series
    required this.blue0,
    required this.blue5,
    required this.blue10,
    required this.blue15,
    required this.blue20,
    required this.blue40,
    required this.blue60,
    required this.blue80,
    required this.blue100,
    required this.trueBlue0,
    required this.trueBlue5,
    required this.trueBlue10,
    required this.trueBlue15,
    required this.trueBlue20,
    required this.trueBlue40,
    required this.trueBlue60,
    required this.trueBlue80,
    required this.trueBlue100,
    required this.trueBlue,
    required this.cyan,
    required this.ankeesBlue,
    required this.techBlue,
    required this.middleBlue,

    // Red Series
    required this.red0,
    required this.red100,
    required this.red,
    required this.champagnePink,
    required this.pinkLady,

    // Yellow / Orange Series
    required this.yellow5,
    required this.yellow100,
    required this.subYellow,
    required this.dutchWhite,
    required this.orange,
    required this.orange100,

    // Material Design Colors (Primary shades - 500)
    required this.materialRed,
    required this.materialPink,
    required this.materialPurple,
    required this.materialDeepPurple,
    required this.materialIndigo,
    required this.materialBlue,
    required this.materialLightBlue,
    required this.materialCyan,
    required this.materialTeal,
    required this.materialGreen,
    required this.materialLightGreen,
    required this.materialLime,
    required this.materialYellow,
    required this.materialAmber,
    required this.materialOrange,
    required this.materialDeepOrange,
    required this.materialBrown,
    required this.materialGrey,
    required this.materialBlueGrey,
  });

  // ===========================================================================
  // Text Styles
  // ===========================================================================

  // Headlines
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

  // Body Text
  static const paragraphTextStyle = TextStyle(
    fontSize: 16,
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

  // Legacy Styles (Grouped by Weight & Size)
  // Bold
  static const bold24TextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.34,
    decoration: TextDecoration.none,
  );

  static const bold20TextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const bold18TextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const bold16TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
    decoration: TextDecoration.none,
  );

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

  // Medium
  static const medium32TextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  static const medium24TextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33,
    decoration: TextDecoration.none,
  );

  static const medium18TextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.33,
    decoration: TextDecoration.none,
  );

  static const medium16TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  static const medium14TextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.7,
    decoration: TextDecoration.none,
  );

  // Regular
  static const regular20TextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.4,
    decoration: TextDecoration.none,
  );

  static const regular18TextStyle = TextStyle(
    fontSize: 18,
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

  static const regular14TextStyle = TextStyle(
    fontSize: 14,
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

  // ===========================================================================
  // Fields
  // ===========================================================================

  // TextStyles
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
  final TextStyle paragraphSemiBold;
  @override
  final TextStyle subText;
  @override
  final TextStyle subTexMedium;
  @override
  final TextStyle smallTex;

  @override
  final TextStyle bold24;
  @override
  final TextStyle bold20;
  @override
  final TextStyle bold18;
  @override
  final TextStyle bold16;
  @override
  final TextStyle bold14;
  @override
  final TextStyle bold12;
  @override
  final TextStyle medium32;
  @override
  final TextStyle medium24;
  @override
  final TextStyle medium18;
  @override
  final TextStyle medium16;
  @override
  final TextStyle medium14;
  @override
  final TextStyle regular20;
  @override
  final TextStyle regular18;
  @override
  final TextStyle regular16;
  @override
  final TextStyle regular14;
  @override
  final TextStyle regular12;
  @override
  final TextStyle regular10;

  // Colors
  // Neutrals
  @override
  final Color background;
  @override
  final Color appBar;
  @override
  final Color white;
  @override
  final Color black;
  @override
  final Color transparent;
  @override
  final Color textColor;
  @override
  final Color textGrey;
  @override
  final Color textLightGrey;
  @override
  final Color smokyBlack;
  @override
  final Color cultured;
  @override
  final Color silver;
  @override
  final Color gentleGray;
  @override
  final Color boldGrey;

  // Gold Series
  @override
  final Color rusticRoseGold;

  // Ink Series
  @override
  final Color ink0;
  @override
  final Color ink5;
  @override
  final Color ink10;
  @override
  final Color ink20;
  @override
  final Color ink40;
  @override
  final Color ink60;
  @override
  final Color ink80;
  @override
  final Color ink100;

  // Green Series
  @override
  final Color green0;
  @override
  final Color green5;
  @override
  final Color green10;
  @override
  final Color green15;
  @override
  final Color green20;
  @override
  final Color green40;
  @override
  final Color green60;
  @override
  final Color green80;
  @override
  final Color green100;
  @override
  final Color mainGreen;
  @override
  final Color darkGreen;
  @override
  final Color secondGreen;
  @override
  final Color palmLeaf;
  @override
  final Color dartmouthGreen;
  @override
  final Color apple;
  @override
  final Color shinyShamrock;
  @override
  final Color honeydew;
  @override
  final Color antiFlashWhite;
  @override
  final Color greenVogue0;
  @override
  final Color greenVogue5;
  @override
  final Color greenVogue10;
  @override
  final Color greenVogue15;
  @override
  final Color greenVogue20;
  @override
  final Color greenVogue25;
  @override
  final Color greenVogue30;
  @override
  final Color greenVogue35;
  @override
  final Color greenVogue40;
  @override
  final Color greenVogue45;
  @override
  final Color greenVogue50;
  @override
  final Color greenVogue55;
  @override
  final Color greenVogue60;
  @override
  final Color greenVogue65;
  @override
  final Color greenVogue70;
  @override
  final Color greenVogue75;
  @override
  final Color greenVogue80;
  @override
  final Color greenVogue85;
  @override
  final Color greenVogue90;
  @override
  final Color greenVogue95;
  @override
  final Color greenVogue100;
  @override
  final Color greenVogue;

  // Blue Series
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
  final Color trueBlue0;
  @override
  final Color trueBlue5;
  @override
  final Color trueBlue10;
  @override
  final Color trueBlue15;
  @override
  final Color trueBlue20;
  @override
  final Color trueBlue40;
  @override
  final Color trueBlue60;
  @override
  final Color trueBlue80;
  @override
  final Color trueBlue100;
  @override
  final Color trueBlue;
  @override
  final Color cyan;
  @override
  final Color ankeesBlue;
  @override
  final Color techBlue;
  @override
  final Color middleBlue;

  // Red Series
  @override
  final Color red0;
  @override
  final Color red100;
  @override
  final Color red;
  @override
  final Color champagnePink;
  @override
  final Color pinkLady;

  // Yellow / Orange Series
  @override
  final Color yellow5;
  @override
  final Color yellow100;
  @override
  final Color subYellow;
  @override
  final Color dutchWhite;
  @override
  final Color orange;
  @override
  final Color orange100;

  // Material Design Colors (Primary shades - 500)
  @override
  final Color materialRed;
  @override
  final Color materialPink;
  @override
  final Color materialPurple;
  @override
  final Color materialDeepPurple;
  @override
  final Color materialIndigo;
  @override
  final Color materialBlue;
  @override
  final Color materialLightBlue;
  @override
  final Color materialCyan;
  @override
  final Color materialTeal;
  @override
  final Color materialGreen;
  @override
  final Color materialLightGreen;
  @override
  final Color materialLime;
  @override
  final Color materialYellow;
  @override
  final Color materialAmber;
  @override
  final Color materialOrange;
  @override
  final Color materialDeepOrange;
  @override
  final Color materialBrown;
  @override
  final Color materialGrey;
  @override
  final Color materialBlueGrey;
}

final lightAppThemes = AppThemes(
  // TextStyles
  headline: AppThemes.headLineTextStyle,
  h1: AppThemes.h1TextStyle,
  h2: AppThemes.h2TextStyle,
  h3: AppThemes.h3TextStyle,
  paragraph: AppThemes.paragraphTextStyle,
  paragraphSemiBold: AppThemes.paragraphSemiBoldTextStyle,
  subText: AppThemes.subTexTextStyle,
  subTexMedium: AppThemes.subTexMediumTextStyle,
  smallTex: AppThemes.smallTexTextStyle,

  // Legacy TextStyles
  bold24: AppThemes.bold24TextStyle,
  bold20: AppThemes.bold20TextStyle,
  bold18: AppThemes.bold18TextStyle,
  bold16: AppThemes.bold16TextStyle,
  bold14: AppThemes.bold14TextStyle,
  bold12: AppThemes.bold12TextStyle,
  medium32: AppThemes.medium32TextStyle,
  medium24: AppThemes.medium24TextStyle,
  medium18: AppThemes.medium18TextStyle,
  medium16: AppThemes.medium16TextStyle,
  medium14: AppThemes.medium14TextStyle,
  regular20: AppThemes.regular20TextStyle,
  regular18: AppThemes.regular18TextStyle,
  regular16: AppThemes.regular16TextStyle,
  regular14: AppThemes.regular14TextStyle,
  regular12: AppThemes.regular12TextStyle,
  regular10: AppThemes.regular10TextStyle,

  // Colors
  // Neutrals
  background: AppColors.white,
  appBar: AppColors.black,
  white: AppColors.white,
  black: AppColors.black,
  transparent: AppColors.transparent,
  textColor: AppColors.black,
  textGrey: AppColors.textGrey,
  textLightGrey: AppColors.textLightGrey,
  smokyBlack: AppColors.smokyBlack,
  cultured: AppColors.cultured,
  silver: AppColors.silver,
  gentleGray: AppColors.gentleGray,
  boldGrey: AppColors.boldGrey,

  // Gold Series
  rusticRoseGold: AppColors.rusticRoseGold,

  // Ink Series
  ink0: AppColors.ink0,
  ink5: AppColors.ink5,
  ink10: AppColors.ink10,
  ink20: AppColors.ink20,
  ink40: AppColors.ink40,
  ink60: AppColors.ink60,
  ink80: AppColors.ink80,
  ink100: AppColors.ink100,

  // Green Series
  green0: AppColors.green0,
  green5: AppColors.green5,
  green10: AppColors.green10,
  green15: AppColors.green15,
  green20: AppColors.green20,
  green40: AppColors.green40,
  green60: AppColors.green60,
  green80: AppColors.green80,
  green100: AppColors.green100,
  mainGreen: AppColors.mainGreen,
  darkGreen: AppColors.darkGreen,
  secondGreen: AppColors.secondGreen,
  palmLeaf: AppColors.palmLeaf,
  dartmouthGreen: AppColors.dartmouthGreen,
  apple: AppColors.apple,
  shinyShamrock: AppColors.shinyShamrock,
  honeydew: AppColors.honeydew,
  antiFlashWhite: AppColors.antiFlashWhite,
  greenVogue0: AppColors.greenVogue0,
  greenVogue5: AppColors.greenVogue5,
  greenVogue10: AppColors.greenVogue10,
  greenVogue15: AppColors.greenVogue15,
  greenVogue20: AppColors.greenVogue20,
  greenVogue25: AppColors.greenVogue25,
  greenVogue30: AppColors.greenVogue30,
  greenVogue35: AppColors.greenVogue35,
  greenVogue40: AppColors.greenVogue40,
  greenVogue45: AppColors.greenVogue45,
  greenVogue50: AppColors.greenVogue50,
  greenVogue55: AppColors.greenVogue55,
  greenVogue60: AppColors.greenVogue60,
  greenVogue65: AppColors.greenVogue65,
  greenVogue70: AppColors.greenVogue70,
  greenVogue75: AppColors.greenVogue75,
  greenVogue80: AppColors.greenVogue80,
  greenVogue85: AppColors.greenVogue85,
  greenVogue90: AppColors.greenVogue90,
  greenVogue95: AppColors.greenVogue95,
  greenVogue100: AppColors.greenVogue100,
  greenVogue: AppColors.greenVogue,

  // Blue Series
  blue0: AppColors.blue0,
  blue5: AppColors.blue5,
  blue10: AppColors.blue10,
  blue15: AppColors.blue15,
  blue20: AppColors.blue20,
  blue40: AppColors.blue40,
  blue60: AppColors.blue60,
  blue80: AppColors.blue80,
  blue100: AppColors.blue100,
  trueBlue0: AppColors.trueBlue0,
  trueBlue5: AppColors.trueBlue5,
  trueBlue10: AppColors.trueBlue10,
  trueBlue15: AppColors.trueBlue15,
  trueBlue20: AppColors.trueBlue20,
  trueBlue40: AppColors.trueBlue40,
  trueBlue60: AppColors.trueBlue60,
  trueBlue80: AppColors.trueBlue80,
  trueBlue100: AppColors.trueBlue100,
  trueBlue: AppColors.trueBlue,
  cyan: AppColors.cyan,
  ankeesBlue: AppColors.ankeesBlue,
  techBlue: AppColors.techBlue,
  middleBlue: AppColors.middleBlue,

  // Red Series
  red0: AppColors.red0,
  red100: AppColors.red100,
  red: AppColors.red,
  champagnePink: AppColors.champagnePink,
  pinkLady: AppColors.pinkLady,

  // Yellow / Orange Series
  yellow5: AppColors.yellow5,
  yellow100: AppColors.yellow100,
  subYellow: AppColors.subYellow,
  dutchWhite: AppColors.dutchWhite,
  orange: AppColors.orange,
  orange100: AppColors.orange100,

  // Material Design Colors (Primary shades - 500)
  materialRed: AppColors.materialRed500,
  materialPink: AppColors.materialPink500,
  materialPurple: AppColors.materialPurple500,
  materialDeepPurple: AppColors.materialDeepPurple500,
  materialIndigo: AppColors.materialIndigo500,
  materialBlue: AppColors.materialBlue500,
  materialLightBlue: AppColors.materialLightBlue500,
  materialCyan: AppColors.materialCyan500,
  materialTeal: AppColors.materialTeal500,
  materialGreen: AppColors.materialGreen500,
  materialLightGreen: AppColors.materialLightGreen500,
  materialLime: AppColors.materialLime500,
  materialYellow: AppColors.materialYellow500,
  materialAmber: AppColors.materialAmber500,
  materialOrange: AppColors.materialOrange500,
  materialDeepOrange: AppColors.materialDeepOrange500,
  materialBrown: AppColors.materialBrown500,
  materialGrey: AppColors.materialGrey500,
  materialBlueGrey: AppColors.materialBlueGrey500,
);

final darkAppThemes = AppThemes(
  // TextStyles
  headline: AppThemes.headLineTextStyle,
  h1: AppThemes.h1TextStyle,
  h2: AppThemes.h2TextStyle,
  h3: AppThemes.h3TextStyle,
  paragraph: AppThemes.paragraphTextStyle,
  paragraphSemiBold: AppThemes.paragraphSemiBoldTextStyle,
  subText: AppThemes.subTexTextStyle,
  subTexMedium: AppThemes.subTexMediumTextStyle,
  smallTex: AppThemes.smallTexTextStyle,

  // Legacy TextStyles
  bold24: AppThemes.bold24TextStyle,
  bold20: AppThemes.bold20TextStyle,
  bold18: AppThemes.bold18TextStyle,
  bold16: AppThemes.bold16TextStyle,
  bold14: AppThemes.bold14TextStyle,
  bold12: AppThemes.bold12TextStyle,
  medium32: AppThemes.medium32TextStyle,
  medium24: AppThemes.medium24TextStyle,
  medium18: AppThemes.medium18TextStyle,
  medium16: AppThemes.medium16TextStyle,
  medium14: AppThemes.medium14TextStyle,
  regular20: AppThemes.regular20TextStyle,
  regular18: AppThemes.regular18TextStyle,
  regular16: AppThemes.regular16TextStyle,
  regular14: AppThemes.regular14TextStyle,
  regular12: AppThemes.regular12TextStyle,
  regular10: AppThemes.regular10TextStyle,

  // Colors
  // Neutrals
  background: AppColors.black,
  appBar: AppColors.white,
  white: AppColors.black, // Inverted for Dark Mode
  black: AppColors.black,
  transparent: AppColors.transparent,
  textColor: AppColors.white,
  textGrey: AppColors.textGrey,
  textLightGrey: AppColors.textLightGrey,
  smokyBlack: AppColors.smokyBlack,
  cultured: AppColors.cultured,
  silver: AppColors.silver,
  gentleGray: AppColors.gentleGray,
  boldGrey: AppColors.boldGrey,

  // Gold Series
  rusticRoseGold: AppColors.rusticRoseGold,

  // Ink Series
  ink0: AppColors.ink0,
  ink5: AppColors.ink5,
  ink10: AppColors.ink10,
  ink20: AppColors.ink20,
  ink40: AppColors.ink40,
  ink60: AppColors.ink60,
  ink80: AppColors.ink80,
  ink100: AppColors.ink100,

  // Green Series
  green0: AppColors.green0,
  green5: AppColors.green5,
  green10: AppColors.green10,
  green15: AppColors.green15,
  green20: AppColors.green20,
  green40: AppColors.green40,
  green60: AppColors.green60,
  green80: AppColors.green80,
  green100: AppColors.green100,
  mainGreen: AppColors.mainGreen,
  darkGreen: AppColors.darkGreen,
  secondGreen: AppColors.secondGreen,
  palmLeaf: AppColors.palmLeaf,
  dartmouthGreen: AppColors.dartmouthGreen,
  apple: AppColors.apple,
  shinyShamrock: AppColors.shinyShamrock,
  honeydew: AppColors.honeydew,
  antiFlashWhite: AppColors.antiFlashWhite,
  greenVogue0: AppColors.greenVogue0,
  greenVogue5: AppColors.greenVogue5,
  greenVogue10: AppColors.greenVogue10,
  greenVogue15: AppColors.greenVogue15,
  greenVogue20: AppColors.greenVogue20,
  greenVogue25: AppColors.greenVogue25,
  greenVogue30: AppColors.greenVogue30,
  greenVogue35: AppColors.greenVogue35,
  greenVogue40: AppColors.greenVogue40,
  greenVogue45: AppColors.greenVogue45,
  greenVogue50: AppColors.greenVogue50,
  greenVogue55: AppColors.greenVogue55,
  greenVogue60: AppColors.greenVogue60,
  greenVogue65: AppColors.greenVogue65,
  greenVogue70: AppColors.greenVogue70,
  greenVogue75: AppColors.greenVogue75,
  greenVogue80: AppColors.greenVogue80,
  greenVogue85: AppColors.greenVogue85,
  greenVogue90: AppColors.greenVogue90,
  greenVogue95: AppColors.greenVogue95,
  greenVogue100: AppColors.greenVogue100,
  greenVogue: AppColors.greenVogue,

  // Blue Series
  blue0: AppColors.blue0,
  blue5: AppColors.blue5,
  blue10: AppColors.blue10,
  blue15: AppColors.blue15,
  blue20: AppColors.blue20,
  blue40: AppColors.blue40,
  blue60: AppColors.blue60,
  blue80: AppColors.blue80,
  blue100: AppColors.blue100,
  trueBlue0: AppColors.trueBlue0,
  trueBlue5: AppColors.trueBlue5,
  trueBlue10: AppColors.trueBlue10,
  trueBlue15: AppColors.trueBlue15,
  trueBlue20: AppColors.trueBlue20,
  trueBlue40: AppColors.trueBlue40,
  trueBlue60: AppColors.trueBlue60,
  trueBlue80: AppColors.trueBlue80,
  trueBlue100: AppColors.trueBlue100,
  trueBlue: AppColors.trueBlue,
  cyan: AppColors.cyan,
  ankeesBlue: AppColors.ankeesBlue,
  techBlue: AppColors.techBlue,
  middleBlue: AppColors.middleBlue,

  // Red Series
  red0: AppColors.red0,
  red100: AppColors.red100,
  red: AppColors.red,
  champagnePink: AppColors.champagnePink,
  pinkLady: AppColors.pinkLady,

  // Yellow / Orange Series
  yellow5: AppColors.yellow5,
  yellow100: AppColors.yellow100,
  subYellow: AppColors.subYellow,
  dutchWhite: AppColors.dutchWhite,
  orange: AppColors.orange,
  orange100: AppColors.orange100,

  // Material Design Colors (Primary shades - 500)
  materialRed: AppColors.materialRed500,
  materialPink: AppColors.materialPink500,
  materialPurple: AppColors.materialPurple500,
  materialDeepPurple: AppColors.materialDeepPurple500,
  materialIndigo: AppColors.materialIndigo500,
  materialBlue: AppColors.materialBlue500,
  materialLightBlue: AppColors.materialLightBlue500,
  materialCyan: AppColors.materialCyan500,
  materialTeal: AppColors.materialTeal500,
  materialGreen: AppColors.materialGreen500,
  materialLightGreen: AppColors.materialLightGreen500,
  materialLime: AppColors.materialLime500,
  materialYellow: AppColors.materialYellow500,
  materialAmber: AppColors.materialAmber500,
  materialOrange: AppColors.materialOrange500,
  materialDeepOrange: AppColors.materialDeepOrange500,
  materialBrown: AppColors.materialBrown500,
  materialGrey: AppColors.materialGrey500,
  materialBlueGrey: AppColors.materialBlueGrey500,
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
