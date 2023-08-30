import 'dart:math' as Math;

import 'package:places/domain/location.dart';

///Утилиты для работы с гео
class GeoUtils {
  /// Проверяет находится ли точка[checkPoint] рядом с другой точкой[centerPoint]
  static bool arePointsNear(
    ///точка 1
    Location checkPoint,

    ///точка 2
    Location centerPoint,

    ///расстояние в км
    int meters,
  ) {
    var ky = 40000 / 360;
    var kx = Math.cos(Math.pi * centerPoint.latitude / 180.0) * ky;
    var dx = (centerPoint.longitude - checkPoint.longitude).abs() * kx;
    var dy = (centerPoint.latitude - checkPoint.latitude).abs() * ky;
    return Math.sqrt(dx * dx + dy * dy) <= meters;
  }
}
