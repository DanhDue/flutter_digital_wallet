// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

/// Utility class for wallet gradient colors and text contrast calculations
class GradientUtils {
  GradientUtils._();

  /// Get gradient colors for a wallet card based on index
  /// Returns a list of 3 colors for the gradient
  static List<Color> getWalletGradientColors(BuildContext context, int walletIndex) {
    // 20 popular gradient combinations used by designers
    final colorSets = [
      // 1. Ocean Blue - Classic blue gradient
      [
        context.appThemes.materialBlue,
        context.appThemes.materialBlue,
        context.appThemes.materialCyan,
      ],
      // 2. Sunset - Warm orange to pink
      [
        context.appThemes.materialOrange,
        context.appThemes.materialOrange,
        context.appThemes.materialPink,
      ],
      // 3. Purple Dream - Purple to pink
      [
        context.appThemes.materialPurple,
        context.appThemes.materialPurple,
        context.appThemes.materialPink,
      ],
      // 4. Forest - Green gradient
      [
        context.appThemes.materialGreen,
        context.appThemes.materialGreen,
        context.appThemes.materialTeal,
      ],
      // 5. Royal - Deep purple to blue
      [
        context.appThemes.materialDeepPurple,
        context.appThemes.materialDeepPurple,
        context.appThemes.materialIndigo,
      ],
      // 6. Flamingo - Pink to orange
      [
        context.appThemes.materialPink,
        context.appThemes.materialPink,
        context.appThemes.materialDeepOrange,
      ],
      // 7. Mint - Light green to cyan
      [
        context.appThemes.materialLightGreen,
        context.appThemes.materialLightGreen,
        context.appThemes.materialCyan,
      ],
      // 8. Berry - Red to purple
      [
        context.appThemes.materialRed,
        context.appThemes.materialRed,
        context.appThemes.materialPurple,
      ],
      // 9. Sky - Light blue gradient
      [
        context.appThemes.materialLightBlue,
        context.appThemes.materialLightBlue,
        context.appThemes.materialCyan,
      ],
      // 10. Peach - Warm peachy gradient
      [
        context.appThemes.materialDeepOrange,
        context.appThemes.materialDeepOrange,
        context.appThemes.materialAmber,
      ],
      // 11. Lavender - Soft purple
      [
        context.appThemes.materialPurple,
        context.appThemes.materialPurple,
        context.appThemes.materialPink,
      ],
      // 12. Emerald - Rich green
      [
        context.appThemes.materialTeal,
        context.appThemes.materialTeal,
        context.appThemes.materialGreen,
      ],
      // 13. Sunrise - Yellow to orange
      [
        context.appThemes.materialAmber,
        context.appThemes.materialAmber,
        context.appThemes.materialOrange,
      ],
      // 14. Twilight - Indigo to purple
      [
        context.appThemes.materialIndigo,
        context.appThemes.materialIndigo,
        context.appThemes.materialPurple,
      ],
      // 15. Coral - Pink to red
      [
        context.appThemes.materialPink,
        context.appThemes.materialPink,
        context.appThemes.materialRed,
      ],
      // 16. Aqua - Cyan to blue
      [
        context.appThemes.materialCyan,
        context.appThemes.materialCyan,
        context.appThemes.materialBlue,
      ],
      // 17. Lime - Bright lime green
      [
        context.appThemes.materialLime,
        context.appThemes.materialLime,
        context.appThemes.materialLightGreen,
      ],
      // 18. Crimson - Deep red
      [
        context.appThemes.materialRed,
        context.appThemes.materialRed,
        context.appThemes.materialDeepOrange,
      ],
      // 19. Sapphire - Deep blue
      [
        context.appThemes.materialBlue,
        context.appThemes.materialBlue,
        context.appThemes.materialIndigo,
      ],
      // 20. Tangerine - Orange gradient
      [
        context.appThemes.materialOrange,
        context.appThemes.materialOrange,
        context.appThemes.materialAmber,
      ],
    ];

    // Use wallet index to ensure unique gradient for each card
    return colorSets[walletIndex % colorSets.length];
  }

  /// Calculate the best text color (white or black) based on gradient luminance
  /// Uses WCAG formula for optimal contrast
  static Color getTextColorForGradient(BuildContext context, int walletIndex) {
    final gradientColors = getWalletGradientColors(context, walletIndex);
    // Use the first color of the gradient to determine luminance
    final baseColor = gradientColors.first;

    // Calculate relative luminance using WCAG formula
    final luminance = baseColor.computeLuminance();

    // Return white for dark backgrounds, black for light backgrounds
    // Threshold of 0.5 provides good contrast
    return luminance > 0.5 ? context.appThemes.black : context.appThemes.white;
  }
}
