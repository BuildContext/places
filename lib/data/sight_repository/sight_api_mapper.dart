import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type/default_sight_types.dart';

/// Маппер для [Sight]
///
/// добавляет extension-функции  [fromApiJson] и [toApiJson]
// Не уверен, что так делают. Ради эксперимента.
// Как вариант можно сделать класс Mapper со статическими функциями.
// Как лучше эти mappers делать?
// А, увидел как сделано в SurfGear template. template/lib/interactor/base/mapper.dart
// Тут наверно лишнее такой механизм
extension SightApiMapper on Sight {
  Sight fromApiJson(Map<String, dynamic> map) {
    // В поле url ожидается массив строк, но возможно там что-то другое
    List<String> urls;
    try {
      urls = (map['urls'] as List).map((e) => e.toString()).toList();
    } catch (e) {
      urls = [];
    }

    return Sight(
      id: map['id'] as int,
      point: GeoPoint(
        lon: map['lng'] as double,
        lat: map['lat'] as double,
      ),
      name: map['name'] as String,
      url: urls.isNotEmpty ? urls.first : '',
      type: getSightTypeByCode(map['placeType'] as String),
      details: map['description'] as String,
    );
  }

  Map<String, dynamic> toApiJson() {
    final map = {
      'name': name,
      'lat': point.lat,
      'lng': point.lon,
      'urls': [url],
      'placeType': type.code,
      'description': details,
    };

    // Если id не задан, то не включаем его в json
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
