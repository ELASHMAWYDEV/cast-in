import 'package:flutter/material.dart';

abstract class AppStyle {
  // Colors
  static Color primaryColor = const Color(0xFF8028c5);
  static Color secondaryColor = const Color(0xFF1d1072);
  static Color primaryBgColor = const Color(0xFFFFFFFF);
  static Color secondaryBgColor = const Color(0xFFeeeeee);
  static Color primaryTextColor = const Color(0xFF000000);
  static Color secondaryTextColor = const Color(0xFF29137c);
  static Color primaryButtonColor = const Color(0xFF8028c5); // To be edited

  // Font Family
  static String primaryFontFamily = 'Poppins';

  // Text Styles
  static TextStyle headingTextStyle1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static TextStyle headingTextStyle2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static TextStyle headingTextStyle3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static TextStyle bodyTextStyle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
  );

  static TextStyle bodyTextStyle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
  );

  static TextStyle bodyTextStyle3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
  );

  static TextStyle textButtonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryBgColor,
  );
}
