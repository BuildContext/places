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

  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
    required this.localPath,
  });
}
