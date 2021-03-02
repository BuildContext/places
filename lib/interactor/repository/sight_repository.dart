import 'package:places/domain/core/pair.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';

/// Интерфейс для репозитория мест
abstract class SightRepository {
  /// Добавляет место,
  /// в случае успеха возвращает [Sight] с назначенным id
  Future<Sight> add(Sight place);

  /// Возвращает список всех мест.
  ///
  /// [count] - количество мест в ответе, если не задано, то возвращает все.
  /// [offset] - сдвиг от начала списка.
  Future<List<Sight>> getList({
    int count,
    int offset,
  });

  /// Возвращает место.
  ///
  /// [id] - идентификатор места
  Future<Sight> get({int id});

  /// Обновляет место.
  ///
  /// [sight] - обновленные данные. Должен быть установлен [place.id]
  /// Возвращает обновленное место.
  Future<Sight> update(Sight sight);

  /// Удаляет место.
  ///
  /// [id] - идентификатор места
  Future<void> delete({int id});

  /// Возвращает список Pair<Sight, double> мест удовлетворяющих фильтру.
  /// Pair.first - само место
  /// Pair.second - расстояние (double) до точки, если передали в [filter] текущую координату и радиус
  /// или -1.0, если filter не передали.
  Future<List<Pair<Sight, double>>> getFilteredList(FilterRequest filter);
}
