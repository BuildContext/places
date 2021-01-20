///Модель данных достопримечательности - Sight

class Sight {
  //название достопримечательности
  final String name;
  //координаты места
  final double lat, lon;
  //путь к фотографии в интернете
  final String url;
  //описание достопримечательности
  final String details;
  //тип достопримечательности (кафе, музей, площадь)
  final String type;

  const Sight(
      {this.name, this.lat, this.lon, this.url, this.details, this.type});
}
