part of 'category_selector_widget.dart';

/// Категории достопримечательностей в enum, содержат модель данних [SightCategoryModel]
enum SightCategory {
  hotel(SightCategoriesData.hotel),
  restaurant(SightCategoriesData.restaurant),
  special(SightCategoriesData.special),
  park(SightCategoriesData.park),
  museum(SightCategoriesData.museum),
  cafe(SightCategoriesData.cafe);

  final SightCategoryModel data;
  const SightCategory(this.data);
}
