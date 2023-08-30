part of 'sight_card.dart';

/// [SightCardVisited] - виджет карточки посещенного места,
/// используется в экране [VisitingScreen],

class SightCardVisited extends SightCard {
  /// действие при нажатии поделится
  final VoidCallback? onTapShareButton;
  final VoidCallback? onTapDeleteButton;

  SightCardVisited({
    this.onTapShareButton,
    this.onTapDeleteButton,
    required super.sight,
  });

  @override
  List<Widget> get sightStatus => sightStatusWidgets(
        isCompleted: false,
        text: 'Цель достигнута 12 окт. 2020',
      );
  @override
  List<Widget> get cardButtons => [
        cardButton(
          onTap: onTapShareButton,
          child: SvgPicture.asset(AppAssets.shareIcon),
        ),
        const SizedBox(
          width: 14,
        ),
        cardButton(
          onTap: onTapDeleteButton,
          child: SvgPicture.asset(AppAssets.closeIcon),
        ),
      ];
}
