import 'package:places/domain/sight_type/sight_type.dart';

/// Класс описывающий параметры фильтра, который формируется
/// на странице FiltersScreen.
/// И используется на SightListScreen, SightSearchScreen
class Filter {
  double minDistance;
  double maxDistance;
  List<SightType> types;
  String nameFilter;

  Filter({
    this.minDistance,
    this.maxDistance,
    this.types,
    this.nameFilter,
  });

  Filter copyWith({
    double minDistance,
    double maxDistance,
    List<SightType> types,
    String nameFilter,
  }) {
    return Filter(
      minDistance: minDistance ?? this.minDistance,
      maxDistance: maxDistance ?? this.maxDistance,
      types: types ?? this.types,
      nameFilter: nameFilter ?? this.nameFilter,
    );
  }

  @override
  String toString() {
    return 'min: $minDistance, max: $maxDistance, types: $types';
  }
}
