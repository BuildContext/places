import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Класс, который используется в [CustomTabBar] для передачи
/// свойств отдельных Табов.
/// Из него [CustomTabBar] составляет элементы [CustomTab]
class CustomTabBarItem {
  final String text;
  final Color activeBgrColor;
  final Color bgrColor;
  final TextStyle activeStyle;
  final TextStyle style;

  CustomTabBarItem({
    @required this.text,
    this.activeStyle = AppTextStyles.visitingActiveTab,
    this.style = AppTextStyles.visitingTab,
    this.activeBgrColor = AppColors.grayBlue,
    this.bgrColor = AppColors.transparent,
  }) : assert(text != null);
}
