import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';

/// SightCard - виджет катрочки с кратким описанием
///  доистопримечательности,
///  - используется как елемент в экране SightListScreen,
///  - использует модель данных Sight

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({this.sight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF5F5F5),
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
                        style: smallBoldTextStyle(color: white),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("res/icons/heart.png")
                            )
                        ),
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
                        style: smallTitleTextStyle(color: secondary),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        sight.details,
                        style: smallTextStyle(color: secondary2),
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
