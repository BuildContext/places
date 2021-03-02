///  Модель тела запроса списка мест с фильтром
class FilterRequest {
  /// Широта
  final double lat;

  /// Долгота
  final double lng;

  /// Радиус поиска
  final double radius;

  /// Фильтр со списком типов мест
  final List<String> typeFilter;

  /// Фильтр по наименованию места
  final String nameFilter;

  const FilterRequest({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  /// преобразуем в map
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
      // но не включаем поля, где значения null или пустой список
    }..removeWhere(
        (key, value) => value == null || (value is Iterable && value.isEmpty));
  }
}
