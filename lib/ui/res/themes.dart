import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_text_styles.dart';

final lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColors.ltPrimaryColor,
  accentColor: AppColors.ltAccentColor,
  disabledColor: AppColors.ltDisabledColor,
  cardColor: AppColors.ltCardColor,
  backgroundColor: AppColors.ltBackgroundColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.ltAccentColor,
    foregroundColor: AppColors.ltBackgroundColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.ltBottomNavBackgroundColor,
    unselectedItemColor: AppColors.ltBottomNavUnselectedColor,
    selectedItemColor: AppColors.ltBottomNavSelectedColor,
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    centerTitle: true,
    elevation: 0.0,
    color: Colors.transparent,
    textTheme: TextTheme(
      // title text style
      headline6:
          AppTextStyles.appBarTitle.copyWith(color: AppColors.ltPrimaryColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: AppTextStyles.bigButtonText,
      primary: AppColors.ltAccentColor,
      minimumSize: const Size.fromHeight(48.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: AppColors.ltPrimaryColor,
      textStyle: AppTextStyles.sightDetailsBtn,
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 2.0,
    thumbColor: AppColors.ltAccentColor,
    activeTrackColor: AppColors.ltAccentColor,
    inactiveTrackColor: AppColors.ltAccentColor.withOpacity(0.3),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: AppColors.ltAccentColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: AppColors.ltAccentColor,
        width: 2.0,
      ),
    ),
    hintStyle: AppTextStyles.addSightCategory
        .copyWith(color: AppColors.ltDisabledColor),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColors.dkPrimaryColor,
  accentColor: AppColors.dkAccentColor,
  disabledColor: AppColors.dkDisabledColor,
  cardColor: AppColors.dkCardColor,
  backgroundColor: AppColors.dkBackgroundColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.dkAccentColor,
    foregroundColor: AppColors.dkBackgroundColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.dkBottomNavBackgroundColor,
    unselectedItemColor: AppColors.dkBottomNavUnselectedColor,
    selectedItemColor: AppColors.dkBottomNavSelectedColor,
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    centerTitle: true,
    elevation: 0.0,
    color: Colors.transparent,
    textTheme: TextTheme(
      // title text style
      headline6:
          AppTextStyles.appBarTitle.copyWith(color: AppColors.dkPrimaryColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: AppTextStyles.bigButtonText,
      primary: AppColors.dkAccentColor,
      minimumSize: const Size.fromHeight(48.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: AppColors.dkPrimaryColor,
      textStyle: AppTextStyles.sightDetailsBtn,
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 2.0,
    thumbColor: AppColors.dkAccentColor,
    activeTrackColor: AppColors.dkAccentColor,
    inactiveTrackColor: AppColors.dkAccentColor.withOpacity(0.3),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.dkAccentColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: AppColors.dkAccentColor,
        width: 2.0,
      ),
    ),
    hintStyle: AppTextStyles.addSightCategory
        .copyWith(color: AppColors.dkDisabledColor),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
);
