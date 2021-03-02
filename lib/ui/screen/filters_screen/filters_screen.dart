import 'package:flutter/material.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight_type/default_sight_types.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/interactor/sight_interactor.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/filters_screen/widget/type_filter_item_widget.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:provider/provider.dart';

/// Экран с фильтрами
///
/// В конструкторе передается текущий фильтр
class FiltersScreen extends StatefulWidget {
  static const String routeName = 'FiltersScreen';

  final Filter filter;

  const FiltersScreen({
    Key key,
    @required this.filter,
  })  : assert(filter != null),
        super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // список категорий
  final List<SightType> _types = defaultSightTypes;

  // Фильтр
  Filter _filter;

  // значения слайдера
  RangeValues _rangeValues;

  // количество элементов, которые попадают под условие фильтра
  int _filteredCount;

  @override
  void initState() {
    super.initState();
    _filter = widget.filter;
    _rangeValues = RangeValues(_filter.minDistance, _filter.maxDistance);
    _updateFilteredCount();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.height < 800;

    final categoryFilterWidget = isSmallScreen
        ? SizedBox(
            height: 115,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _types.length,
              itemBuilder: _buildFilterItem,
              separatorBuilder: (_, __) {
                return const SizedBox(width: 32.0);
              },
            ),
          )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _types.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            itemBuilder: _buildFilterItem,
          );

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _onClearFilters,
            child: const Text(AppStrings.filtersClear),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.filtersCategories,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 24.0),
            categoryFilterWidget,
            const SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.filtersDistance,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(_getDistanceLabel()),
              ],
            ),
            RangeSlider(
                values: _rangeValues,
                min: Config.minRange,
                max: Config.maxRange,
                onChangeEnd: (_) {
                  // считаем количество отфильтрованных элементов когда
                  // пользователь закончил изменения, чтобы не дергать будущий
                  // репозиторий при каждом движении слайдера
                  _filter.minDistance = _rangeValues.start;
                  _filter.maxDistance = _rangeValues.end;
                  _updateFilteredCount();
                },
                onChanged: (newValues) {
                  setState(() => _rangeValues = newValues);
                }),
            const Spacer(),
            IconElevatedButton(
              text: _buildShowButtonLabel(),
              onPressed: _onShowTap,
            ),
          ],
        ),
      ),
    );
  }

  // Элемент фильтра
  Widget _buildFilterItem(BuildContext context, int index) {
    return TypeFilterItemWidget(
      sightType: _types[index],
      isSelected: _isTypeSelected(_types[index]),
      onTap: () {
        _onTypeSelect(_types[index]);
        _updateFilteredCount();
      },
    );
  }

  // выдает строку диапазона расстояний для подсказки наверху слайдера.
  String _getDistanceLabel() {
    String distLabel(double distanceMeters) {
      if (distanceMeters >= 1000) {
        return '${(distanceMeters / 1000).toStringAsFixed(2)}${AppStrings.filtersDistanceKilometers}';
      }
      return '${distanceMeters.toStringAsFixed(0)}${AppStrings.filtersDistanceMeters}';
    }

    return '${AppStrings.filtersFrom} ${distLabel(_rangeValues.start)} ${AppStrings.filtersTo} ${distLabel(_rangeValues.end)}';
  }

  // надпись на кнопке с количеством результатов по фильтру
  String _buildShowButtonLabel() {
    if (_filteredCount == null) {
      return AppStrings.filtersShow.toUpperCase();
    }
    return '${AppStrings.filtersShow.toUpperCase()} ($_filteredCount)';
  }

  // количество точек, которые попадают под условие фильтра
  Future<void> _updateFilteredCount() async {
    final int count = (await context
            .read<SightInteractor>()
            .getFilteredSights(filter: _filter))
        .length;
    setState(() {
      _filteredCount = count;
    });
  }

  // сбрасывает фильтры в начальное значение
  void _onClearFilters() {
    _filter.minDistance = Config.minRange;
    _filter.maxDistance = Config.maxRange;
    _filter.types.clear();
    setState(() {
      _rangeValues = RangeValues(_filter.minDistance, _filter.maxDistance);
    });
    _updateFilteredCount();
  }

  // При тапе на категорию добавляем или убираем ее в фильтре
  void _onTypeSelect(SightType type) {
    setState(() {
      _isTypeSelected(type)
          ? _filter.types.remove(type)
          : _filter.types.add(type);
    });
  }

  bool _isTypeSelected(SightType type) => _filter.types.contains(type);

  void _onShowTap() {
    Navigator.of(context).pop(_filter);
  }
}
