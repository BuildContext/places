import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';

/// SightCardCompleted - карточка посещенной доистопримечательности
///  - используется как елемент в экране VisitingScreen,
///  - использует модель данных Sight

class SightCardCompleted extends StatelessWidget {
  final Sight sight;

  const SightCardCompleted({this.sight});

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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: sight.url,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text(text_error_network_connect),
                    ),
                  ),
                ),
                Expanded(
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
                              style: smallTitleTextStyle(
                                  color: Theme.of(context).accentColor),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 28,
                              child: Text(
                                sc_completed,
                                style: smallTextStyle(
                                    color: lmSecondaryLightColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              sight.details,
                              style:
                                  smallTextStyle(color: lmSecondaryLightColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                type: MaterialType.transparency,
                child: Stack(
                  children: [
                    InkWell(
                      splashColor: rippleColour,
                      onTap: () {
                        print('Card was TAPPED');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sight.type,
                            style: smallBoldTextStyle(color: lmWhiteColor),
                          ),
                          Row(
                            children: [
                              FloatingActionButton(
                                elevation: 0.0,
                                splashColor: rippleColour,
                                onPressed: () {
                                  print("shareIcon");
                                },
                                backgroundColor: Colors.transparent,
                                mini: true,
                                child: SvgPicture.asset(shareIcon),
                              ),
                              FloatingActionButton(
                                elevation: 0.0,
                                splashColor: rippleColour,
                                onPressed: () {
                                  print("closeIcon");
                                },
                                backgroundColor: Colors.transparent,
                                mini: true,
                                child: SvgPicture.asset(closeIcon),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
