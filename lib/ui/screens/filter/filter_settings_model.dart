import 'package:flutter/material.dart';
import 'package:places/ui/screens/filter/widgets/category_selector_widget/category_selector_widget.dart';

/// Модель фильтра
class FilterSettings {
  final Set<SightCategory> categories;

  /// текушщий диапазон
  final RangeValues currentRange;

  /// максимально доступный диапазон
  final RangeValues availableRange;

  FilterSettings({
    required this.categories,
    required this.currentRange,
    required this.availableRange,
  });

  FilterSettings copyWith({
    Set<SightCategory>? categories,
    RangeValues? range,
  }) {
    return FilterSettings(
      categories: categories ?? this.categories,
      currentRange: range ?? this.currentRange,
      availableRange: availableRange,
    );
  }
}
