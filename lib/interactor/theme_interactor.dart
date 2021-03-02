import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';

/// Интерактор настроек
class ThemeInteractor extends ChangeNotifier {
  bool _isDark = false;

  /// Текущая тема приложения
  ThemeData get theme => _isDark ? darkTheme : lightTheme;

  /// флаг темной темы
  bool get isDark => _isDark;

  /// устанавливает темную тему
  set isDark(bool newVal) {
    _isDark = newVal;
    notifyListeners();
  }
}
