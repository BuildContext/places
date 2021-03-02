/// Список доступных SVG-ресурсов для виджета [SvgIcon]
class SvgIcons {
  static const SvgData route = SvgData(
    'res/svg/route.svg',
    semanticsLabel: 'Route',
  );

  static const SvgData calendar = SvgData(
    'res/svg/calendar.svg',
    semanticsLabel: 'Calendar',
  );

  static const SvgData info = SvgData(
    'res/svg/info.svg',
    semanticsLabel: 'Info',
  );

  static const SvgData hotel = SvgData(
    'res/svg/hotel.svg',
    semanticsLabel: 'Hotel',
  );

  static const SvgData cafe = SvgData(
    'res/svg/cafe.svg',
    semanticsLabel: 'Cafe',
  );

  static const SvgData place = SvgData(
    'res/svg/place.svg',
    semanticsLabel: 'Special place',
  );

  static const SvgData park = SvgData(
    'res/svg/park.svg',
    semanticsLabel: 'Park',
  );

  static const SvgData museum = SvgData(
    'res/svg/museum.svg',
    semanticsLabel: 'Museum',
  );

  static const SvgData restaurant = SvgData(
    'res/svg/restouraunt.svg',
    semanticsLabel: 'Restaurant',
  );

  static const SvgData arrowRight = SvgData(
    'res/svg/arrow_right.svg',
    semanticsLabel: 'Arrow right',
  );

  static const SvgData arrowLeft = SvgData(
    'res/svg/arrow_left.svg',
    semanticsLabel: 'Arrow left',
  );

  static const SvgData tick = SvgData(
    'res/svg/tick.svg',
    semanticsLabel: 'Tick',
  );

  static const SvgData clear = SvgData(
    'res/svg/clear.svg',
    semanticsLabel: 'Clear',
  );

  static const SvgData plus = SvgData(
    'res/svg/plus.svg',
    semanticsLabel: 'Plus',
  );

  static const SvgData list = SvgData(
    'res/svg/list.svg',
    semanticsLabel: 'List',
  );

  static const SvgData listFill = SvgData(
    'res/svg/list_fill.svg',
    semanticsLabel: 'List',
  );

  static const SvgData map = SvgData(
    'res/svg/map.svg',
    semanticsLabel: 'Map',
  );

  static const SvgData mapFill = SvgData(
    'res/svg/map_fill.svg',
    semanticsLabel: 'Map',
  );

  static const SvgData heart = SvgData(
    'res/svg/heart.svg',
    semanticsLabel: 'Heart',
  );

  static const SvgData heartFill = SvgData(
    'res/svg/heart_fill.svg',
    semanticsLabel: 'Heart',
  );

  static const SvgData settings = SvgData(
    'res/svg/settings.svg',
    semanticsLabel: 'Settings',
  );

  static const SvgData settingsFill = SvgData(
    'res/svg/settings_fill.svg',
    semanticsLabel: 'Settings',
  );

  static const SvgData filter = SvgData(
    'res/svg/filter.svg',
    semanticsLabel: 'Filter',
  );

  static const SvgData search = SvgData(
    'res/svg/search.svg',
    semanticsLabel: 'Search',
  );

  static const SvgData error = SvgData(
    'res/svg/error.svg',
    semanticsLabel: 'Error',
  );

  static const SvgData delete = SvgData(
    'res/svg/delete.svg',
    semanticsLabel: 'Delete',
  );

  static const SvgData bucket = SvgData(
    'res/svg/bucket.svg',
    semanticsLabel: 'Bucket',
  );

  static const SvgData onboarding1 = SvgData(
    'res/svg/onboarding1.svg',
    semanticsLabel: '',
  );

  static const SvgData onboarding2 = SvgData(
    'res/svg/onboarding2.svg',
    semanticsLabel: '',
  );

  static const SvgData onboarding3 = SvgData(
    'res/svg/onboarding3.svg',
    semanticsLabel: '',
  );

  static const SvgData logo = SvgData(
    'res/svg/logo.svg',
    semanticsLabel: 'Logo',
  );

  static const SvgData camera = SvgData(
    'res/svg/camera.svg',
    semanticsLabel: 'Camera',
  );

  static const SvgData photo = SvgData(
    'res/svg/photo.svg',
    semanticsLabel: 'Photo',
  );

  static const SvgData file = SvgData(
    'res/svg/file.svg',
    semanticsLabel: 'File',
  );

  static const SvgData share = SvgData(
    'res/svg/share.svg',
    semanticsLabel: 'Share',
  );
}

/// Описание SVG-ресурса
class SvgData {
  final String path;
  final String semanticsLabel;

  const SvgData(this.path, {this.semanticsLabel});
}
