part of 'category_selector_widget.dart';

/// Модель данных фильтра "Категории" используются в enum [SightCategory]
class SightCategoryModel {
  final String title;
  final String iconPath;

  const SightCategoryModel({
    required this.title,
    required this.iconPath,
  });
}
