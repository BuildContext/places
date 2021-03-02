import 'package:places/domain/geo_point.dart';
import 'package:places/interactor/repository/location_repository.dart';

/// Моковые данные для текущего местоположения
class LocationRepositoryMock implements LocationRepository {
  GeoPoint _currentLocation;

  /// Отдает местоположение с задержкой 500ms
  @override
  Future<GeoPoint> getCurrentLocation() {
    if (_currentLocation != null) {
      return Future.value(_currentLocation);
    } else {
      _currentLocation = GeoPoint(lon: 30.433278, lat: 59.685994);
      return Future.delayed(const Duration(milliseconds: 10), () {
        return Future.value(_currentLocation);
      });
    }
  }
}
