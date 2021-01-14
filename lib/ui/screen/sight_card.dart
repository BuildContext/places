import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

/*
* SightCard - виджет катрочки с кратким описанием
*  доистопримечательности,
*  - используется как елемент в экране SightListScreen,
*  - использует модель данных Sight
*/
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({this.sight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    color: Colors.yellow,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 47, top: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.name,
                    style: TextStyle(
                        color: Color(0xFF3B3E5B),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    maxLines: 2,
                  ),
                  Text(
                    sight.details,
                    style: TextStyle(
                      color: Color(0xFF7C7E92),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
