import 'package:flutter/material.dart';
import 'package:places/constants/colours_const.dart';

final basicTheme = ThemeData(
  fontFamily: 'Roboto',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
);

final lightTheme = basicTheme.copyWith(
    primaryColor: lmWhiteColor,
    accentColor: black,
    scaffoldBackgroundColor: lmWhiteColor,
    backgroundColor: lmWhiteColor,
    cardColor: lmCardColor);

final darkTheme = basicTheme.copyWith(
  primaryColor: dmDarkColor,
  accentColor: lmWhiteColor,
  scaffoldBackgroundColor: dmSecondaryColor,
  backgroundColor: dmSecondaryColor,
  cardColor: dmDarkColor,
);
