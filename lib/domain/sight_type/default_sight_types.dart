import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Предустановленные категории мест, используются в фильтре.
final List<SightType> defaultSightTypes = [
  const SightType(
    name: 'Отель',
    icon: SvgIcons.hotel,
    code: 'hotel',
  ),
  const SightType(
    name: 'Ресторан',
    icon: SvgIcons.restaurant,
    code: 'restaurant',
  ),
  const SightType(
    name: 'Особое место',
    icon: SvgIcons.place,
    code: 'other',
  ),
  const SightType(
    name: 'Парк',
    icon: SvgIcons.park,
    code: 'park',
  ),
  const SightType(
    name: 'Музей',
    icon: SvgIcons.museum,
    code: 'museum',
  ),
  const SightType(
    name: 'Кафе',
    icon: SvgIcons.cafe,
    code: 'cafe',
  ),
];

/// Функция возвращает экземпляр [SightType] с соответствующим [code] из [defaultSightTypes]
/// Или null, если нет такого кода
SightType getSightTypeByCode(String code) {
  return defaultSightTypes.singleWhere(
    (e) => e.code == code,
    orElse: () => null,
  );
}
