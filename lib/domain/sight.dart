/* Модель данных достопримечательности - Sight,
* name - название достопримечательности
* lat, lon - координаты места
* url - путь к фотографии в интернете
* details - описание достопримечательности
* type - тип достопримечательности (кафе, музей, площадь)
*/
class Sight {
  final String name;
  final double lat, lon;
  final String url;
  final String details;
  final String type;

  const Sight(
      {this.name, this.lat, this.lon, this.url, this.details, this.type});
}
