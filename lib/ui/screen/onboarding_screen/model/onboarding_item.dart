import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Описание элемента для страницы онбординга.
///
/// Сами элементы определяются в [_OnboardingScreenState]
class OnboardingItem {
  final String title;
  final String subTitle;
  final SvgData icon;

  OnboardingItem({this.title, this.subTitle, this.icon});
}
