import 'dart:math';

import 'package:places/domain/core/pair.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/sight_repository.dart';

/// Репозиторий мест. Данные в памяти. Для тестов
///
/// примерно так будет выглядеть репозиторий с данными в db
class SightRepositoryMemory implements SightRepository {
  final List<Sight> _sights = [];

  // текущий индекс autoincrement
  int _currentId = 0;

  /// Добавляет место,
  /// в случае успеха возвращает [Sight] с назначенным id
  @override
  Future<Sight> add(Sight sight) async {
    final newSight = sight.copyWith(id: _currentId);
    _sights.add(newSight);
    _currentId++;
    return Future.value(newSight);
  }

  /// Удаляет место.
  ///
  /// [id] - идентификатор места
  @override
  Future<void> delete({int id}) async {
    _sights.removeWhere((element) => element.id == id);
  }

  /// Возвращает место.
  ///
  /// [id] - идентификатор места
  @override
  Future<Sight> get({int id}) async {
    final sight = _sights.singleWhere(
      (element) => element.id == id,
      orElse: () => null,
    );
    return sight != null ? Future.value(sight) : Future.error('Not found');
  }

  /// Возвращает List<Map<Sight, double>> список мест удовлетворяющих фильтру.
  /// value в Map -
  /// расстояние (double) до точки, если передали в [filter] текущую координату и радиус
  /// или -1.0, если filter не передали.
  @override
  Future<List<Pair<Sight, double>>> getFilteredList(
      FilterRequest filter) async {
    final filteredByNameAndType = _sights.where((p) {
      // отфильтровываем по типу места
      return filter.typeFilter == null ||
          filter.typeFilter.isEmpty ||
          filter.typeFilter.contains(p.type.code);
    }).where((p) {
      // отфильтровываем по имени
      return filter.nameFilter == null ||
          filter.nameFilter == '' ||
          p.name
              .trim()
              .toLowerCase()
              .contains(filter.nameFilter.trim().toLowerCase());
    });

    if (filter.radius == null || filter.lat == null || filter.lng == null) {
      // Если запрос был без фильтра по координате
      // расстояния не считаем и передаем -1
      final result = filteredByNameAndType.map((p) => Pair(p, -1.0));
      return Future.value(result.toList());
    } else {
      // Если запрос был с фильтром по координате, то делаем фильтрацию
      final filteredByDist = filteredByNameAndType.where((p) {
        // Отфильтровываем по расстоянию
        final dist = _getDistance(
          point: GeoPoint(lat: p.point.lat, lon: p.point.lon),
          center: GeoPoint(lat: filter.lat, lon: filter.lng),
        );
        return dist < filter.radius;
      }).map((p) {
        final dist = _getDistance(
          point: GeoPoint(lat: p.point.lat, lon: p.point.lon),
          center: GeoPoint(lat: filter.lat, lon: filter.lng),
        );
        return Pair(p, dist);
      });
      return Future.value(filteredByDist.toList());
    }
  }

  /// Возвращает список всех мест.
  ///
  /// [count] - количество мест в ответе, если не задано, то возвращает все.
  /// [offset] - сдвиг от начала списка.
  @override
  Future<List<Sight>> getList({int count, int offset}) async {
    List<Sight> slice = [];
    int start, end;

    // Если начальная позиция за пределами списка, то возвращаем пустой список
    if (offset > 0 || offset < _sights.length) {
      start = offset;
    } else {
      return Future.value(slice);
    }

    // Если запрошено больше элементов, чем есть, то возвращаем то что осталось
    end = (offset + count < _sights.length) ? offset + count : _sights.length;

    slice = _sights.sublist(start, end);
    return Future.value(slice);
  }

  /// Обновляет место.
  ///
  /// [sight] - обновленные данные. Должен быть установлен [place.id]
  /// Возвращает обновленное место.
  @override
  Future<Sight> update(Sight sight) async {
    final index = _sights.indexWhere((element) => element.id == sight.id);
    if (index == -1) {
      return Future.error('Not found');
    }
    _sights[index] = sight;
    return Future.value(sight);
  }

  /// Возвращает расстояние между [point] и [center] в метрах.
  double _getDistance({
    GeoPoint point,
    GeoPoint center,
  }) {
    const double ky = 40000000 / 360;
    final double kx = cos(pi * point.lat / 180.0) * ky;
    final double dx = (point.lon - center.lon).abs() * kx;
    final double dy = (point.lat - center.lat).abs() * ky;
    final double dis = sqrt(dx * dx + dy * dy);
    return dis;
  }
}
