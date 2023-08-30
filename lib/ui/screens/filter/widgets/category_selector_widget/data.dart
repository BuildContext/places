part of 'category_selector_widget.dart';

/// Данные фильтра "Категории"
class SightCategoriesData {
  static const hotel = SightCategoryModel(
        title: AppStrings.categoryHotel,
        iconPath: AppAssets.hotelIcon,
      ),
      restaurant = SightCategoryModel(
        title: AppStrings.categoryRestaurant,
        iconPath: AppAssets.restourantIcon,
      ),
      special = SightCategoryModel(
        title: AppStrings.categorySpecial,
        iconPath: AppAssets.specialPlaceIcon,
      ),
      park = SightCategoryModel(
        title: AppStrings.categoryPark,
        iconPath: AppAssets.parkIcon,
      ),
      museum = SightCategoryModel(
        title: AppStrings.categoryMuseum,
        iconPath: AppAssets.museumIcon,
      ),
      cafe = SightCategoryModel(
        title: AppStrings.categoryCafe,
        iconPath: AppAssets.cafeIcon,
      );
}
