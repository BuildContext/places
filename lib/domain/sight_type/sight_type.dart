import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Категория места
///
/// [code] - код тип места в api
/// доступные в api: temple, monument, park, theatre, museum, hotel, restaurant, cafe, other
class SightType {
  final String name;
  final String code;
  final SvgData icon;

  const SightType({
    this.name,
    this.icon,
    this.code,
  });

  @override
  String toString() => 'SightType(name: $name, code: $code)';
}
