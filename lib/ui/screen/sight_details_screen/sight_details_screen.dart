import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/widget/sight_photos_carousel.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/icon_text_button.dart';

/// Экран подробного представления "Интересного места"
// todo deprecate
class SightDetailsScreen extends StatefulWidget {
  static const String routeName = 'SightDetailsScreen';

  final Sight sight;

  const SightDetailsScreen({Key key, @required this.sight}) : super(key: key);

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Тут можно было бы организовать все через SliverAppBar,
          // но в качестве тренировки сделал
          // через SliverPersistentHeader с minExtent = 0
          SliverPersistentHeader(
            delegate: DetailsSliverPersistentHeaderDelegate(
              photos: sightPhotosMocks,
              onBackTap: _onBack,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.sight.name,
                      style: AppTextStyles.sightDetailsTitle),
                  const SizedBox(height: 2.0),
                  Text(widget.sight.type.name,
                      style: AppTextStyles.sightDetailsType),
                  const SizedBox(height: 24.0),

                  // Имитируем много текста в описании * 6
                  Text(widget.sight.details * 6,
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
                      IconTextButton(
                        icon: SvgIcons.heart,
                        text: AppStrings.sightDetailsToFavoriteBtn,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    // При скролле кнопка "back" делается прозрачной, в середине скролла.
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
        Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 36.0),
            child: InkWell(
              onTap: onBackTap,
              child: Container(
                height: 32.0,
                width: 32.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 16.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        )
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
