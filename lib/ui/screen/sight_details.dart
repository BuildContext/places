import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';

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
            picturesAndBackButton(),
            descriptionAndButtoms(),
          ],
        ),
      ),
    );
  }

  Widget picturesAndBackButton() {
    return Container(
        height: 361,
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                sight.localPath,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
            Positioned(
              left: 16,
              top: 36,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: black,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget descriptionAndButtoms() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sight.name,
                style: mediumTitleTextStyle(color: secondary),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  sight.type,
                  style: smallBoldTextStyle(color: secondary),
                ),
                const SizedBox(width: 16),
                Text(
                  sight_details_open,
                  style: smallTextStyle(color: secondary2),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              sight.details,
              style: smallTextStyle(color: secondary),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFF4CAF50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_rounded,
                    size: 24,
                    color: Colors.white,
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
            const SizedBox(height: 24),
            Divider(
              thickness: 0.8,
              color: secondary2.withOpacity(0.4),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 22,
                          color: secondary2.withOpacity(0.4),
                        ),
                        const SizedBox(width: 9),
                        Text(
                          sight_details_to_plan,
                          style: smallTextStyle(
                            color: secondary2.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate,
                          size: 22,
                          color: secondary,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          sight_details_to_favorites,
                          style: smallTextStyle(color: secondary),
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
