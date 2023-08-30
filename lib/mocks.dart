import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/filter/widgets/category_selector_widget/category_selector_widget.dart';

/*
* класс с моковыми данными
*/

class MockData {
  static const List<Sight> sights = [
    Sight(
      name: '1 test',
      location: Location(
        50.375323,
        30.444760,
      ),
      url: 'url',
      details: 'details',
      type: SightCategory.cafe,
      localPath: 'localPath',
    ),
    Sight(
      name: '2 test',
      location: Location(
        50.368687,
        30.237245,
      ),
      url: 'url',
      details: 'details',
      type: SightCategory.park,
      localPath: 'localPath',
    ),
    Sight(
      name: '3 test',
      location: Location(
        50.447154,
        30.108921,
      ),
      url: 'url',
      details: 'details',
      type: SightCategory.hotel,
      localPath: 'localPath',
    ),
    Sight(
      name: '4 test',
      location: Location(
        50.281594,
        30.210077,
      ),
      url: 'url',
      details: 'details',
      type: SightCategory.special,
      localPath: 'localPath',
    ),
    Sight(
      name: '5 test',
      location: Location(
        50.281594,
        30.210077,
      ),
      url: 'url',
      details: 'details',
      type: SightCategory.museum,
      localPath: 'localPath',
    ),
    Sight(
      name: "McDonalds",
      location: Location(
        50.411229,
        30.384493,
      ),
      url:
          "https://lh5.googleusercontent.com/p/AF1QipP-gS3JDLdSGjvFBROmayKY8TwIJGHwxgNngaPn=s676-k-no",
      localPath: "res/images/1.jpg",
      details: "Еда, есть макДрайв",
      type: SightCategory.cafe,
    ),
    Sight(
      name: "Шлоссплац Штутгарт",
      location: Location(
        48.7778493,
        9.1788645,
      ),
      url:
          "https://lh5.googleusercontent.com/p/AF1QipO3ZgO3lppkofF7yJCZ9mhDclwJp_nGxMc5FaBb=s653-k-no",
      localPath: "res/images/2.jpg",
      details:
          "Площадь центре города Штутгарт, Германия с колонной, историческими зданиями и садами.",
      type: SightCategory.museum,
    ),
    Sight(
      name: "Национальный музей Эфиопии",
      location: Location(
        49.037679,
        38.7618785,
      ),
      url:
          "https://lh5.googleusercontent.com/p/AF1QipP3Seo4aJeI9WOzYF2wa-qfxEtSR5vXimCHAGwT=s773-k-no",
      localPath: "res/images/3.jpg",
      details:
          "Музей с коллекцией современной живописи, древними экспонатами и останками австралопитека Люси.",
      type: SightCategory.museum,
    ),
    Sight(
      name: "Сэнсодзи",
      location: Location(
        35.7147707533258,
        139.79664702450793,
      ),
      url:
          "https://lh5.googleusercontent.com/p/AF1QipMGG43SvNbWVli2_lSr0cXz09SjG8651Z-xvWxL=s653-k-no",
      localPath: "res/images/5.jpg",
      details:
          "Старейший храм Токио, построенный в 645 году в честь богини милосердия Каннон.",
      type: SightCategory.special,
    ),
    Sight(
      name: "Заказник Блэкбат",
      location: Location(
        -32.9373566383028,
        151.69752873623014,
      ),
      url:
          "https://lh5.googleusercontent.com/p/AF1QipMrZxO9bMwntIFd-AMSx3Pn-mjaiHILSJVFoho-=s653-k-no",
      localPath: "res/images/5.jpg",
      details:
          "Это отличное место, чтобы увидеть кенгуру и эму. Вы также увидите живых павлинов, которые бродят по парку и раскидывают свои перья. ",
      type: SightCategory.park,
    ),
    Sight(
      name: "Sangeh Monkey Forest",
      location: Location(
        -8.481782490735712,
        115.20673723982037,
      ),
      url:
          "https://lh5.googleusercontent.com/p/AF1QipNDiMy4LcVYVLqhZyZMiD7pcvHecxC2hauJubgp=s676-k-no",
      localPath: "res/images/6.jpg",
      details:
          "Храм в лесу, под высоченными деревьями, с бассейном для обезьян",
      type: SightCategory.park,
    ),
  ];
}
