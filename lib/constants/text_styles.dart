import 'package:flutter/material.dart';

TextStyle largeTitleTextStyle({color}) {
  return TextStyle(
    fontSize: 32,
    color: color,
    fontWeight: FontWeight.w700,
  );
}

TextStyle mediumTitleTextStyle({color}) {
  return TextStyle(
    fontSize: 24,
    color: color,
    fontWeight: FontWeight.w700,
  );
}

TextStyle smallTitleTextStyle({color}){
  return TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 16);
}

TextStyle smallBoldTextStyle({color}) {
  return TextStyle(
    fontSize: 14,
    color: color,
    fontWeight: FontWeight.w700,
  );
}

TextStyle smallTextStyle({color}){
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

TextStyle buttonBigTextStyle({color}){
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: 1.2,
  );
}