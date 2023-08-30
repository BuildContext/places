import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';

import 'package:places/ui/screens/sight_list_screen.dart' show SightListScreen;
import 'package:places/ui/screens/visiting_screen.dart' show VisitingScreen;

part 'planned_sight_card.dart';
part 'visited_sight_card.dart';

/// [SightCard] - виджет катрочки с кратким описанием
/// используется в экране [SightListScreen],
/// использует модель данных [Sight]

class SightCard extends StatelessWidget {
  final Sight sight;
  final VoidCallback? onTapToFavoriteButton;

  const SightCard({
    required this.sight,
    this.onTapToFavoriteButton,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        height: 188,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            topHalfOfCard,
            bottomHalfOfCard,
          ],
        ),
      ),
    );
  }

  Widget get topHalfOfCard {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              image: DecorationImage(
                image: NetworkImage(sight.url),
                //TODO: NetworkImage bad url exception
                onError: (exception, stackTrace) {
                  print(exception);
                },
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sight.type.data.title,
                  style: AppTextStyles.smallBoldTextStyle(
                      color: AppColors.lmWhiteColor),
                ),
                Row(
                  children: cardButtons,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get bottomHalfOfCard {
    return Builder(builder: (context) {
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 250,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    sight.name,
                    style: AppTextStyles.smallTitleTextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 2,
                  ),
                  ...sightStatus,
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    sight.details,
                    style: AppTextStyles.smallTextStyle(
                        color: AppColors.lmSecondaryLightColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> sightStatusWidgets({
    required String text,
    required bool isCompleted,
  }) =>
      [
        Container(
          height: 28,
          child: Text(
            text,
            style: AppTextStyles.smallTextStyle(
              color: isCompleted
                  ? AppColors.lmGreenColour
                  : AppColors.lmSecondaryLightColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ];

  /// To override in superclass
  List<Widget> get sightStatus => [];
  List<Widget> get cardButtons => [_favoriteToggleButton];

  Widget get _favoriteToggleButton => cardButton(
        onTap: onTapToFavoriteButton,
        child: SvgPicture.asset(AppAssets.heartIcon),
      );

  Widget cardButton({Widget? child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        child: child,
      ),
    );
  }
}
