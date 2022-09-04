import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';

/// экран с подробной информацией
/// о интересном месте, а также
/// кнопками "Проложить маршрут", "В избранное"
/// и "Запланировать"
/// - использует модель данных Sight

class SightDetailScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailScreen({
    required this.sight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            picturesAndBackButton(),
            descriptionAndButtons(),
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
                  color: lmWhiteColor,
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

  Widget descriptionAndButtons() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sight.name,
                style: mediumTitleTextStyle(color: lmSecondaryColor),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  sight.type,
                  style: smallBoldTextStyle(color: lmSecondaryColor),
                ),
                const SizedBox(width: 16),
                Text(
                  sight_details_open,
                  style: smallTextStyle(color: lmSecondaryLightColor),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              sight.details,
              style: smallTextStyle(color: lmSecondaryColor),
            ),
            const SizedBox(height: 24),
            DetailBigButton(
              onTap: (() {
                print('ПОСТРОИТЬ МАРШРУТ');
              }),
              icon: Icons.directions_rounded,
              text: sight_details_directions,
            ),
            const SizedBox(height: 24),
            Divider(
              thickness: 0.8,
              color: lmSecondaryLightColor.withOpacity(0.4),
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
                          color: lmSecondaryLightColor.withOpacity(0.4),
                        ),
                        const SizedBox(width: 9),
                        Text(
                          sight_details_to_plan,
                          style: smallTextStyle(
                            color: lmSecondaryLightColor.withOpacity(0.4),
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
                          color: lmSecondaryColor,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          sight_details_to_favorites,
                          style: smallTextStyle(color: lmSecondaryColor),
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

class DetailBigButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  const DetailBigButton({
    Key? key,
    this.onTap,
    this.icon,
    this.iconColor = lmWhiteColor,
    required this.text,
    this.textColor = lmWhiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: lmGreenColour,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
            Text(
              text,
              style: buttonBigTextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
