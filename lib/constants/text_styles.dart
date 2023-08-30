import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle largeTitleTextStyle({Color? color}) {
    return TextStyle(
      fontSize: 32,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle mediumTitleTextStyle({Color? color}) {
    return TextStyle(
      fontSize: 24,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle smallTitleTextStyle({Color? color}) {
    return TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 16);
  }

  static TextStyle subtitleTextStyle({Color? color}) {
    return TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 18);
  }

  static TextStyle smallBoldTextStyle({Color? color}) {
    return TextStyle(
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle smallTextStyle({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle buttonBigTextStyle({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 1.2,
    );
  }
}
