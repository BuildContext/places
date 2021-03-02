import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/interactor/favorites_interactor.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/widget/sight_photos_carousel.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/icon_text_button.dart';
import 'package:provider/provider.dart';

/// BottomSheet подробного представления "Интересного места"
class SightDetailsBottomSheet extends StatefulWidget {
  final Sight sight;

  const SightDetailsBottomSheet({
    Key key,
    @required this.sight,
  })  : assert(sight != null),
        super(key: key);

  @override
  _SightDetailsBottomSheetState createState() =>
      _SightDetailsBottomSheetState();
}

class _SightDetailsBottomSheetState extends State<SightDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      minChildSize: 0.6,
      initialChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(
                  delegate: DetailsSliverPersistentHeaderDelegate(
                    photos: sightPhotosMocks,
                    onBackTap: _onBack,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.sight.name,
                            style: AppTextStyles.sightDetailsTitle),
                        const SizedBox(height: 2.0),
                        Text(widget.sight.type.name,
                            style: AppTextStyles.sightDetailsType),
                        const SizedBox(height: 24.0),
                        Text(widget.sight.details,
                            style: AppTextStyles.sightDetailsDetails),
                        const SizedBox(height: 24.0),
                        IconElevatedButton(
                          icon: SvgIcons.route,
                          text: AppStrings.sightDetailsRouteToBtn.toUpperCase(),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 32.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const IconTextButton(
                              icon: SvgIcons.calendar,
                              text: AppStrings.sightDetailsPlanBtn,
                            ),
                            StreamBuilder<bool>(
                              stream: context
                                  .read<FavoritesInteractor>()
                                  .favoriteStream(widget.sight),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox.shrink();
                                }
                                final bool isFav = snapshot.data;
                                return IconTextButton(
                                  onPressed: () {
                                    context
                                        .read<FavoritesInteractor>()
                                        .switchFavorite(widget.sight);
                                  },
                                  text: AppStrings.sightDetailsToFavoriteBtn,
                                  icon: isFav
                                      ? SvgIcons.heartFill
                                      : SvgIcons.heart,
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onBack() {
    Navigator.of(context).pop();
  }
}

/// Sliver-делегат для заголовка с каруселью фото
///
/// [photos] - список фото для карусели
/// [onBackTap] - при тапе на кнопку back
class DetailsSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final List<SightPhoto> photos;
  final VoidCallback onBackTap;

  DetailsSliverPersistentHeaderDelegate({
    @required this.photos,
    @required this.onBackTap,
  })  : assert(photos != null && onBackTap != null),
        super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // При скролле кнопка "back" и ушко делаеются прозрачными,
    // в середине скролла.
    // Высчитываем прозрачность в соответствии с shrinkOffset
    final startOpacityOffset = maxExtent - 200;
    final endOpacityOffset = maxExtent - 100;
    final currentOpacityOffset =
        shrinkOffset.clamp(startOpacityOffset, endOpacityOffset).toDouble() -
            startOpacityOffset;
    final opacity =
        1 - currentOpacityOffset / (endOpacityOffset - startOpacityOffset);

    return Stack(
      children: [
        SightPhotosCarousel(list: photos),

        // Кнопка закрытия
        Opacity(
          opacity: opacity,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: InkWell(
                onTap: onBackTap,
                child: SvgIcon(
                  icon: SvgIcons.clear,
                  size: 40,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
        ),

        // Ушко
        Opacity(
          opacity: opacity,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                height: 4.0,
                width: 40.0,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
