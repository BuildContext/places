part of 'sight_card.dart';

/// [SightCardPlanned] - виджет карточки запланированого похода,
/// используется в экране [VisitingScreen],

class SightCardPlanned extends SightCard {
  /// действие при нажатии выбора даты
  final VoidCallback? onTapDateSelectorButton;
  final VoidCallback? onTapDeleteButton;

  SightCardPlanned({
    this.onTapDateSelectorButton,
    this.onTapDeleteButton,
    required super.sight,
  });

  @override
  List<Widget> get sightStatus => sightStatusWidgets(
      isCompleted: false, text: 'Запланировано на 12 окт. 2020');
  @override
  List<Widget> get cardButtons => [
        cardButton(
          onTap: onTapDateSelectorButton,
          child: SvgPicture.asset(calendarIcon),
        ),
        const SizedBox(
          width: 14,
        ),
        cardButton(
          onTap: onTapDeleteButton,
          child: SvgPicture.asset(closeIcon),
        ),
      ];
}
