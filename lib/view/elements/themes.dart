import 'package:crimespy/view/elements/colors.dart';
import 'package:flutter/material.dart';

class TextThemes {
  static final TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Archivo-Bold',
    color: cTextNavy,
  );

  static final TextStyle info = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Archivo-Regular',
    color: cTextNavy,
  );

  static final TextStyle detail = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    fontFamily: 'Archivo-Regular',
    color: cTextNavy,
  );

  static final TextStyle dateStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFFffa62b),
    fontFamily: 'Archivo-Regular',
  );

  static final TextStyle username = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Archivo-SemiBold',
    color: Colors.blue[700],
  );
}
