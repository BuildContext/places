import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/domain/sight_type/default_sight_types.dart';
import 'package:places/interactor/repository/sight_repository.dart';

/// Места
final List<Sight> mocks = [
  Sight(
    name: 'Дворцовая площадь',
    details:
        'Главная площадь Санкт-Петербурга, находится перед Зимним дворцом. Ее размеры почти в два раза превышают столичную Красную площадь. Архитектурный ансамбль с идеальными геометрическими пропорциями возводился в XVIII-XIX столетиях. Посередине площади находится монументальная Александрийская колонна, которая посвящена победе Российской империи над армией Наполеона. Колонна была воздвигнута по указу Николая I.',
    url:
        'https://top10.travel/wp-content/uploads/2016/11/dvorcovaya-ploschad.jpg',
    point: GeoPoint(
      lon: 30.312733,
      lat: 59.940073,
    ),
    type: getSightTypeByCode('museum'),
  ),
  Sight(
    name: 'Музей-заповедник Павловск',
    details:
        'Дворцово-парковый ансамбль, расположившийся на территории 600 Га. Раньше на этих землях находились царские охотничьи угодья. В 1777 году земли были переданы во владения наследному принцу Павлу I, который задумал возвести здесь для себя грандиозную резиденцию. За четыре года построили дворец и разбили парк. После кончины Павла I в резиденции проживала его вдова, которая вложила много сил и средств на расширение и украшение комплекса.',
    url:
        'https://top10.travel/wp-content/uploads/2016/11/muzey-zapovednik-pavlovsk.jpg',
    point: GeoPoint(
      lon: 30.433278,
      lat: 59.685994,
    ),
    type: getSightTypeByCode('museum'),
  ),
  Sight(
    name: 'Петергоф',
    details:
        'Бывшая императорская загородная резиденция, которую основал Петр Великий в начале XVIII столетия. Этот грандиозный дворцово-парковый ансамбль называют «русским Версалем». За три столетия существования облик Петергофа достаточно сильно изменился, а после Войны 1941-1945 гг. его восстановили буквально из обломков. На территории комплекса располагаются десятки фонтанов, цветники, прогулочные аллеи и павильоны, которые напоминают об имперской эпохе российской истории.',
    url: 'https://top10.travel/wp-content/uploads/2016/11/petergof.jpg',
    point: GeoPoint(
      lon: 29.906775,
      lat: 59.881223,
    ),
    type: getSightTypeByCode('museum'),
  ),
  Sight(
    name: 'Большой Екатерининский дворец',
    details:
        'Дворцовый комплекс располагается в окрестностях Петербурга в г. Пушкин. До начала XX века он назывался Большой Царскосельский дворец. Первый царский дом возник здесь в первой половине XVIII столетия. Расширение началось в 1750-хх гг. во время правления Елизаветы под руководством архитектора Растрелли. Дворец возводился в стиле классического барокко, в пышных внутренних интерьерах преобладают элементы рококо.',
    url:
        'https://top10.travel/wp-content/uploads/2016/11/bolshoy-ekaterininskiy-dvorets.jpg',
    point: GeoPoint(
      lon: 30.395414,
      lat: 59.715871,
    ),
    type: getSightTypeByCode('museum'),
  ),
  Sight(
    name: 'Государственный Эрмитаж',
    details:
        'Крупнейший в России музей, который наряду с испанским Прадо, парижским Лувром и музеями Ватикана входит в список самых выдающихся и ценных собраний произведений искусства в мире. Экспозиции Эрмитажа занимают 6 зданий, здесь хранится порядка 3 млн. экспонатов. Настоящая гордость музея – здание Зимнего дворца, где располагалась резиденция царской фамилии. Этот великолепный комплекс был выстроен Бартоломео Растрелли в стиле «елизаветинского барокко».',
    url: 'https://top10.travel/wp-content/uploads/2016/11/ermitazh.jpg',
    point: GeoPoint(
      lon: 30.312733,
      lat: 59.940073,
    ),
    type: getSightTypeByCode('museum'),
  ),
];

/// Загрузка созданных моков на сервер, чтобы вручную не создавать
/// Вызывается в main()
Future<void> uploadMocks(SightRepository placeRepository) async {
  // final PlaceRepository placeRepository = PlaceRepositoryNetwork();
  // final PlaceRepository placeRepository = PlaceRepositoryMemory();
  for (final sight in mocks) {
    await placeRepository.add(sight);
  }
}

/// Фотографии мест
final List<SightPhoto> sightPhotosMocks = [
  const SightPhoto(url: 'https://picsum.photos/800/600?1'),
  const SightPhoto(url: 'https://picsum.photos/800/600?2'),
  const SightPhoto(url: 'https://picsum.photos/800/600?3'),
  const SightPhoto(url: 'https://picsum.photos/800/600?4'),
  const SightPhoto(url: 'https://picsum.photos/800/600?5'),
  const SightPhoto(url: 'https://picsum.photos/800/600?6'),
  const SightPhoto(url: 'https://picsum.photos/800/600?8'),
  const SightPhoto(url: 'https://picsum.photos/800/600?9'),
  const SightPhoto(url: 'https://picsum.photos/800/600?10'),
  const SightPhoto(url: 'https://picsum.photos/800/600?11'),
  const SightPhoto(url: 'https://picsum.photos/800/600?12'),
  const SightPhoto(url: 'https://picsum.photos/800/600?13'),
  const SightPhoto(url: 'https://picsum.photos/800/600?14'),
  const SightPhoto(url: 'https://picsum.photos/800/600?15'),
  const SightPhoto(url: 'https://picsum.photos/800/600?16'),
  const SightPhoto(url: 'https://picsum.photos/800/600?17'),
  const SightPhoto(url: 'https://picsum.photos/800/600?18'),
  const SightPhoto(url: 'https://picsum.photos/800/600?19'),
  const SightPhoto(url: 'https://picsum.photos/800/600?20'),
];

/// Текущий индекс фотографии, чтобы не повторялись
int currentMockIndex = 0;
