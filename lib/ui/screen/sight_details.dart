import 'package:flutter/material.dart';
import 'package:places/constants.dart';
import 'package:places/domain/sight.dart';

/*
* SightDetails - модель экрана с подробной информацией
*  о интересном месте, а также
*  кнопками "Проложить маршрут", "В избранное"
*  и "Запланировать"
* - использует модель данных Sight
*/

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails({this.sight});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [picturesAndBackButton(), descriptionAndButtons()],
      ),
    );
  }

  Widget picturesAndBackButton() {
    return Container(
        height: 361,
        child: Stack(
          children: [
            Container(
              color: Colors.brown,
            ),
            Positioned(
              left: 16,
              top: 36,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3B3E5B),
                ),
              ),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Text(
                  sight.type,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3B3E5B),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  sight_details_open,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7C7E92),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              sight.details,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF3B3E5B),
              ),
            ),
            SizedBox(height: 24),
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sight_details_directions,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Divider(
              thickness: 0.8,
              color: Color(0xFF7C7E92).withOpacity(0.4),
            ),
            SizedBox(height: 8),
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
                          color: Color(0xFF7C7E92).withOpacity(0.4),
                        ),
                        SizedBox(width: 9),
                        Text(
                          sight_details_to_plan,
                          style: TextStyle(
                            color: Color(0xFF7C7E92).withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
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
                          color: Color(0xFF7C7E92).withOpacity(0.4),
                        ),
                        SizedBox(width: 9),
                        Text(
                          sight_details_to_favorites,
                          style: TextStyle(
                              color: Color(0xFF7C7E92).withOpacity(0.4),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
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
