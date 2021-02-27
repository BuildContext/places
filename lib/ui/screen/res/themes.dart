import 'package:flutter/material.dart';
import 'package:places/constants/colours_const.dart';

final basicTheme = ThemeData(
  fontFamily: 'Roboto',
  splashColor: rippleColour,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
);

final lightTheme = basicTheme.copyWith(
    primaryColor: white,
    accentColor: black,
    scaffoldBackgroundColor: white,
    backgroundColor: white,
    colorScheme: ColorScheme(
        primary: lmMainColor,
        primaryVariant: Colors.transparent,
        secondary: lmSecondaryColor,
        secondaryVariant: lmSecondaryLightColor,
        surface: lmCardColor,
        background: white,
        error: lmRedColor,
        onPrimary: Colors.transparent,
        onSecondary: Colors.transparent,
        onSurface: Colors.transparent,
        onBackground: lmYellowColor,
        onError: lmGreenColour,
        brightness: Brightness.light));

final darkTheme = basicTheme.copyWith(
    primaryColor: black, //text colour
    accentColor: white,
    scaffoldBackgroundColor: dmMainColor,
    backgroundColor: dmMainColor,
    colorScheme: ColorScheme(
        primary: dmMainColor,
        primaryVariant: Colors.transparent,
        secondary: dmSecondaryColor,
        secondaryVariant: dmSecondaryLightColor,
        surface: dmCardColor,
        background: dmMainColor,
        error: dmRedColor,
        onPrimary: Colors.transparent,
        onSecondary: Colors.transparent,
        onSurface: Colors.transparent,
        onBackground: dmYellowColor,
        onError: dmGreenColor,
        brightness: Brightness.dark));

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? darkTheme : lightTheme;
  }
}
