import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/widgets/button/accept_big_button.dart';

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
                //TODO: asset errorBuilder
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
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
                  color: AppColors.lmWhiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
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
                style: AppTextStyles.mediumTitleTextStyle(
                    color: AppColors.lmSecondaryColor),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  sight.type.data.title,
                  style: AppTextStyles.smallBoldTextStyle(
                      color: AppColors.lmSecondaryColor),
                ),
                const SizedBox(width: 16),
                Text(
                  AppStrings.sightDetailsOpen,
                  style: AppTextStyles.smallTextStyle(
                      color: AppColors.lmSecondaryLightColor),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              sight.details,
              style: AppTextStyles.smallTextStyle(
                  color: AppColors.lmSecondaryColor),
            ),
            const SizedBox(height: 24),
            AcceptBigButton(
              onTap: (() {
                print('ПОСТРОИТЬ МАРШРУТ');
              }),
              icon: Icons.directions_rounded,
              text: AppStrings.sightDetailsDirections,
            ),
            const SizedBox(height: 24),
            Divider(
              thickness: 0.8,
              color: AppColors.lmSecondaryLightColor.withOpacity(0.4),
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
                          color:
                              AppColors.lmSecondaryLightColor.withOpacity(0.4),
                        ),
                        const SizedBox(width: 9),
                        Text(
                          AppStrings.sightDetailsToPlan,
                          style: AppTextStyles.smallTextStyle(
                            color: AppColors.lmSecondaryLightColor
                                .withOpacity(0.4),
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
                          color: AppColors.lmSecondaryColor,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          AppStrings.sightDetailsToFavorites,
                          style: AppTextStyles.smallTextStyle(
                              color: AppColors.lmSecondaryColor),
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
