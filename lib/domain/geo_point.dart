/// Класс, описывающий гео-координату точки.
class GeoPoint {
  final double lon;
  final double lat;

  GeoPoint({this.lon, this.lat});

  @override
  String toString() {
    return 'GeoPoint(lon: $lon, lat: $lat)';
  }
}
