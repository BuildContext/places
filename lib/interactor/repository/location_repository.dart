import 'package:places/domain/geo_point.dart';

/// Интерфейс для репозитория для доступа к текущему местоположению
abstract class LocationRepository {
  /// Отдает текущее местоположение в виде [GeoPoint]
  Future<GeoPoint> getCurrentLocation();
}
