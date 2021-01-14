class Sight{
  final String name; // название достопримечательности
  final double lat, lon; // координаты места
  final String url; // путь до фотографии в интернете
  final String details; // описание достопримечательности
  final String type; // тип достопримечательности

  const Sight({
    this.name,
    this.lat,
    this.lon,
    this.url,
    this.details,
    this.type
  });
}
