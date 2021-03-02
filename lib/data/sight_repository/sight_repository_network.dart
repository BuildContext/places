import 'dart:convert';

import 'package:places/data/network_client/network_client.dart';
import 'package:places/data/sight_repository/sight_api_mapper.dart';
import 'package:places/domain/core/pair.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/sight_repository.dart';

/// Репозиторий мест. Данные на сервере
class SightRepositoryNetwork implements SightRepository {
  static const String _getListUrl = '/place';
  static const String _addUrl = '/place';
  static const String _getFilteredUrl = '/filtered_places';

  final NetworkClient client;

  SightRepositoryNetwork(this.client);

  /// Возвращает список всех мест.
  ///
  /// [count] - количество мест в ответе, если не задано, то возвращает все.
  /// [offset] - сдвиг от начала списка.
  @override
  Future<List<Sight>> getList({int count, int offset}) async {
    // Если передать пустые параметры, то сервер отдает 400,
    // поэтому передаем параметры только если они заданы.
    Map<String, dynamic> params;
    if (count != null) params['count'] = count;
    if (offset != null) params['offset'] = offset;

    final response = await client.get(_getListUrl, params);

    final sightsJson = jsonDecode(response);
    final sights = (sightsJson as List)
        .map((p) => Sight().fromApiJson(p as Map<String, dynamic>))
        .toList();
    return sights;
  }

  /// Возвращает List<Map<Sight, double>> список мест удовлетворяющих фильтру.
  /// value в Map -
  /// расстояние (double) до точки, если передали в [filter] текущую координату и радиус
  /// или -1.0, если filter не передали.
  @override
  Future<List<Pair<Sight, double>>> getFilteredList(
      FilterRequest filter) async {
    final body = jsonEncode(filter.toJson());

    final response = await client.post(_getFilteredUrl, body);

    final sightsJson = jsonDecode(response);
    final sights = (sightsJson as List).map((p) {
      final sight = Sight().fromApiJson(p as Map<String, dynamic>);
      // api не возвращает distance, хотя в swagger описано.
      final distance = p['distance'] as double ?? 0;
      return Pair(sight, distance);
    }).toList();

    return sights;
  }

  @override
  Future<Sight> add(Sight sight) async {
    final body = jsonEncode(sight.toApiJson());

    final response = await client.post(_addUrl, body);

    final sightJson = jsonDecode(response);
    return Sight().fromApiJson(sightJson as Map<String, dynamic>);
  }

  @override
  Future<Sight> get({int id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({int id}) {
    throw UnimplementedError();
  }

  @override
  Future<Sight> update(Sight place) {
    throw UnimplementedError();
  }
}

// Функция для парсинга Json в изоляте
// ignore: unused_element
dynamic _parseJson(String jsonData) {
  return jsonDecode(jsonData);
}
