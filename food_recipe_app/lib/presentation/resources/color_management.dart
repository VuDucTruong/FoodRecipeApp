import 'dart:ui';

import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = const Color(0xFFF5F3EE);
  static Color secondaryColor = const Color(0xFFE9455D);
  static Color accentColor = const Color(0xFF0DC0DE);
  static Color darkBlueColor = const Color(0xFF103C4A);
  static Color blueColor = const Color(0xFF0DC0DE);
  static Color whiteOrangeColor = const Color(0xFFF8C89A);
  static Color pinkColor = const Color(0xFFFA9BB1);
  static Color vegColor = const Color(0xFF03A100);
  static Color nonVegColor = const Color(0xFFA10000);
  static LinearGradient linearGradientSecondary = const LinearGradient(
    colors: [
      Color(0xFFE9455D),
      Color(0xFFFA9BB1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient linearGradientPink = const LinearGradient(
    colors: [
      Color(0xFFFA9BB1),
      Color(0xFFF8C89A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient linearGradientWhiteOrange = const LinearGradient(
    colors: [
      Color(0xFFF8C89A),
      Color(0xFFF8C89A),
      Color(0xFFF3FAFF),
    ],
    stops: [0.0, 0.0001, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient linearGradientBlue = const LinearGradient(
    colors: [
      Color(0xFF0DC0DE),
      Color(0xFFF8C89A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient linearGradientDarkBlue = const LinearGradient(
    colors: [
      Color(0xFF103C4A),
      Color(0xFF0DC0DE),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
