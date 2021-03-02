import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight_type/sight_type.dart';

/// Место
class Sight {
  final int id;
  final String name;
  final String url;
  final String details;
  final GeoPoint point;
  final SightType type;

  Sight({
    this.id,
    this.name,
    this.url,
    this.details,
    this.type,
    this.point,
  });

  Sight copyWith({
    int id,
    String name,
    String url,
    String details,
    GeoPoint point,
    SightType type,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (url == null || identical(url, this.url)) &&
        (details == null || identical(details, this.details)) &&
        (point == null || identical(point, this.point)) &&
        (type == null || identical(type, this.type))) {
      return this;
    }

    return Sight(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      details: details ?? this.details,
      point: point ?? this.point,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'Sight(id: $id name: $name)';
  }
}
