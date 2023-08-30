import 'package:flutter/material.dart';
import 'package:places/constants/colours_const.dart';

final basicTheme = ThemeData(
  fontFamily: 'Roboto',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    elevation: 0, // This removes the shadow from all App Bars.
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 0.5,
    //TODO: replace to AppColors
    activeTickMarkColor: Colors.white,
    thumbColor: Colors.white,
    activeTrackColor: Color(0xFF4CAF50),
    inactiveTrackColor: Color.fromRGBO(124, 126, 146, 0.56),
  ),
);

final lightTheme = basicTheme.copyWith(
  primaryColor: AppColors.lmWhiteColor,
  colorScheme: basicTheme.colorScheme.copyWith(secondary: AppColors.black),
  scaffoldBackgroundColor: AppColors.lmWhiteColor,
  backgroundColor: AppColors.lmWhiteColor,
  cardColor: AppColors.lmCardColor,
);

final darkTheme = basicTheme.copyWith(
  primaryColor: AppColors.dmDarkColor,
  colorScheme:
      basicTheme.colorScheme.copyWith(secondary: AppColors.lmWhiteColor),
  scaffoldBackgroundColor: AppColors.dmSecondaryColor,
  backgroundColor: AppColors.dmSecondaryColor,
  cardColor: AppColors.dmDarkColor,
);
