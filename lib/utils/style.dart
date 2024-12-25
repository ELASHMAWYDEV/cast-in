import 'package:flutter/material.dart';

abstract class AppStyle {
  // Colors
  static Color primaryColor = const Color.fromRGBO(128, 40, 197, 1); // #8028C5
  static Color secondaryColor = const Color.fromRGBO(29, 16, 114, 1); // #1D1072
  static Color primaryBgColor = const Color.fromRGBO(255, 255, 255, 1); // #FFFFFF
  static Color secondaryBgColor = const Color.fromRGBO(238, 238, 238, 1); // #EEEEEE
  static Color primaryTextColor = const Color.fromRGBO(0, 0, 0, 1); // #000000
  static Color secondaryTextColor = const Color.fromRGBO(41, 19, 124, 1); // #29137C
  static Color primaryButtonColor = const Color.fromRGBO(128, 40, 197, 1);
  static Color grey = const Color.fromRGBO(124, 125, 143, 1);
  static Color darkGrey = const Color.fromRGBO(113, 113, 113, 1);
  static Color more = const Color.fromRGBO(7, 8, 56, 1);

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
  static TextStyle subTitleStyle1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );
  static TextStyle subTitleStyle2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: secondaryColor,
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryBgColor,
  );
  static TextStyle appBarTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );
}
