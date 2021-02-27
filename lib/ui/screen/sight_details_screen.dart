import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/dark_theme_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:provider/provider.dart';

/// SightDetails - модель экрана с подробной информацией
/// о интересном месте, а также
///  кнопками "Проложить маршрут", "В избранное"
/// и "Запланировать"
/// - использует модель данных Sight

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails({this.sight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            picturesAndBackButton(context),
            descriptionAndButtons(context),
          ],
        ),
      ),
    );
  }

  Widget picturesAndBackButton(context) {
    
    return Container(
      color: Theme.of(context).accentColor,
      height: 361,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: sight.url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: Text(text_error_network_connect),
            ),
          ),
          Positioned(
            left: 16,
            top: 36,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.background,
              ),
              child: InkWell(
                onTap: () {
                  print("backDetails");
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).accentColor,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionAndButtons(context) {
    bool isDarkTheme = Provider.of<DarkThemeProvider>(context).darkTheme;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sight.name,
                style: mediumTitleTextStyle(
                    color: isDarkTheme
                        ? white
                        : Theme.of(context).colorScheme.secondary),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  sight.type,
                  style: smallBoldTextStyle(
                      color: isDarkTheme
                          ? Theme.of(context).colorScheme.secondaryVariant
                          : Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(width: 16),
                Text(
                  sight_details_open,
                  style: smallTextStyle(
                      color: isDarkTheme
                          ? Theme.of(context).colorScheme.secondaryVariant
                          : Theme.of(context)
                              .colorScheme
                              .secondaryVariant
                              .withOpacity(0.6)),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                sight.details,
                style: smallTextStyle(
                    color: isDarkTheme
                        ? white
                        : Theme.of(context).colorScheme.secondary),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                print("build a route");
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onError,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "res/icons/union_white.svg",
                      color: white,
                      height: 22,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      sight_details_directions,
                      style: buttonBigTextStyle(color: white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Divider(
              thickness: 0.8,
              color: Theme.of(context)
                  .colorScheme
                  .secondaryVariant
                  .withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "res/icons/calendar.svg",
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryVariant
                              .withOpacity(0.6),
                        ),
                        const SizedBox(width: 9),
                        Text(
                          sight_details_to_plan,
                          style: smallTextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryVariant
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "res/icons/bottom_nav/heart.svg",
                          color: isDarkTheme
                              ? white
                              : Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          sight_details_to_favorites,
                          style: smallTextStyle(
                              color: isDarkTheme
                                  ? white
                                  : Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
