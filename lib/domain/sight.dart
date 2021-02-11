///Модель данных достопримечательности - Sight

class Sight {
  //название достопримечательности
  final String name;
  //координаты места
  final double lat, lon;
  //путь к фотографии в интернете
  final String url;
  //путь к фотографии локально
  final String localPath;
  //описание достопримечательности
  final String details;
  //тип достопримечательности (кафе, музей, площадь)
  final String type;

  const Sight(
      {this.name, this.lat, this.lon, this.url, this.details, this.type,  this.localPath});
}
