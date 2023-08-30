import 'package:places/domain/location.dart';
import 'package:places/ui/screens/filter/widgets/category_selector_widget/category_selector_widget.dart'
    show SightCategory;

///Модель данных достопримечательности - Sight

class Sight {
  //название достопримечательности
  final String name;
  //координаты места
  final Location location;
  //путь к фотографии в интернете
  final String url;
  //путь к фотографии локально
  final String localPath;
  //описание достопримечательности
  final String details;
  //тип достопримечательности (кафе, музей, площадь)
  final SightCategory type;

  const Sight({
    required this.name,
    required this.location,
    required this.url,
    required this.details,
    required this.type,
    required this.localPath,
  });
}
