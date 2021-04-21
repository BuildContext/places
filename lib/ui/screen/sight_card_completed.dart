import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';

/// SightCardCompleted - карточка посещенной доистопримечательности
///  - используется как елемент в экране [VisitingScreen],
///  - использует модель данных [Sight]

class SightCardCompleted extends StatelessWidget {
  final Sight sight;

  const SightCardCompleted({this.sight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage(sight.localPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sight.type,
                        style: smallBoldTextStyle(color: lmWhiteColor),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(shareIcon),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(closeIcon),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
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
                          "Цель достигнута 12 окт. 2020",
                          style: smallTextStyle(color: lmSecondaryLightColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        sight.details,
                        style: smallTextStyle(color: lmSecondaryLightColor),
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
    );
  }
}
