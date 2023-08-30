import 'package:flutter/material.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/filter/widgets/distance_selector_widget.dart';
import 'package:places/ui/widgets/button/accept_big_button.dart';
import 'package:places/utils/extensions/set_extensions.dart';
import 'package:places/utils/geo_utils.dart';

import 'filter_settings_model.dart';
import 'widgets/category_selector_widget/category_selector_widget.dart';

class FilterScreen extends StatefulWidget {
  final FilterSettings? initialFilterSettings;
  final List<Sight> sigths;
  final Location currentUserLocation;
  const FilterScreen({
    Key? key,
    //TODO: передавать настройки фильтра и места в конструктор
    this.initialFilterSettings,
    this.sigths = MockData.sights,
    this.currentUserLocation = const Location(
      50.431342,
      30.482338,
    ),
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //TODO: логика сохранения настроек
  late var filterSettings = widget.initialFilterSettings ??
      //TODO: передавать настройки фильтра в конструктор
      FilterSettings(
        categories: {...SightCategory.values},
        currentRange: RangeValues(3, 25),
        availableRange: RangeValues(0, 30),
      );
  late List<Sight> filtredSights;

  @override
  void initState() {
    getFiltredSights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        child: Column(
          children: [
            FilterCategoryLabel(),
            SizedBox(
              height: 24,
            ),
            FilterCategoriesWidget(
              allCategories: SightCategory.values,
              onTapCategory: changeFilterCategories,
              selectedCategories: filterSettings.categories,
            ),
            DistanceSelectorWidget(
              onDistanceChange: changeFilterDistance,
              debounce: const Duration(milliseconds: 100),
              currentRange: filterSettings.currentRange,
              availableRange: filterSettings.availableRange,
            ),
            AcceptBigButton(
              onTap: (() {
                print('FILTER');
              }),
              text:
                  '${AppStrings.filterAcceptButton.toUpperCase()} (${filtredSights.length})',
            ),
          ],
        ),
      ),
    );
  }

  Row FilterCategoryLabel() {
    return Row(
      children: [
        Text(
          AppStrings.categoryLabel.toUpperCase(),
          //TODO: replace style
          style: TextStyle(
            color: Color.fromRGBO(124, 126, 146, 0.56),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void changeFilterDistance(RangeValues newRange) {
    filterSettings = filterSettings.copyWith(range: newRange);
    getFiltredSights();
    setState(() {});
  }

  void changeFilterCategories(SightCategory selected) {
    filterSettings.categories.addOrRemove(selected);
    getFiltredSights();
    setState(() {});
  }

  void getFiltredSights() {
    filtredSights = SightFilterUtil.run(
      filterSettings,
      widget.sigths,
      widget.currentUserLocation,
    );
    // print(filtredSights.first.location.latitude);
    // print(filtredSights.first.location.longitude);
  }

  PreferredSizeWidget get appBar {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        iconSize: 32.0,
        color: AppColors.lmMainColor,
        icon: const Icon(Icons.chevron_left),
        onPressed: () {},
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {});
          },
          child: Text(
            AppStrings.filterClear,
            //TODO: replace style
            style: TextStyle(
              fontSize: 16,
              color: AppColors.lmGreenColour,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class SightFilterUtil {
  static List<Sight> run(
    FilterSettings filterSettings,
    List<Sight> allSights,
    Location userLocation,
  ) {
    var categoryFiltred =
        _filterByCategory(allSights, filterSettings.categories);
    var categoryAndRangeFiltred = _filterByRange(
        categoryFiltred, filterSettings.currentRange, userLocation);
    return categoryAndRangeFiltred;
  }

  static List<Sight> _filterByRange(
    List<Sight> sights,
    RangeValues? range,
    Location userLocation,
  ) {
    if (range == null) {
      return sights;
    }
    // отсекаем все места которые ближе минимального значения слайдера
    var minRangeSights = sights
        .where(
          (sight) => !GeoUtils.arePointsNear(
            sight.location,
            userLocation,
            range.start.toInt(),
          ),
        )
        .toList();
    // отсекаем все места которые дальше максимального значения слайдера
    var minMaxRangeSights = minRangeSights
        .where(
          (sight) => GeoUtils.arePointsNear(
            sight.location,
            userLocation,
            range.end.toInt(),
          ),
        )
        .toList();
    return minMaxRangeSights;
  }

  static List<Sight> _filterByCategory(
    List<Sight> sights,
    Set<SightCategory> categories,
  ) =>
      sights.where((sight) => categories.contains(sight.type)).toList();
}
