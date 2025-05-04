import 'package:flutter/material.dart';

class AppSizes {
  static late double primaryFontSize;
  static late double secondaryFontSize;
  static late double tertiaryFontSize;

  static late double largeIconSize;
  static late double mediumIconSize;
  static late double smallIconSize;

  static late double largeGap;
  static late double mediumGap;
  static late double smallGap;

  static late EdgeInsets padding;

  static void init(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    primaryFontSize = screenWidth * 0.06;
    secondaryFontSize = screenWidth * 0.045;
    tertiaryFontSize = screenWidth * 0.035;

    largeIconSize = screenWidth * 0.08;
    mediumIconSize = screenWidth * 0.06;
    smallIconSize = screenWidth * 0.045;

    largeGap = screenHeight * 0.04;
    mediumGap = screenHeight * 0.025;
    smallGap = screenHeight * 0.015;

    padding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.05,
      vertical: screenHeight * 0.02,
    );
  }
}
