import 'package:flutter/material.dart';

class ColorManager {
  static const Color secondaryColor = Color(0xFFE9455D);
  static const Color primaryColor = Color(0xFFF5F3EE);
  static const Color accentColor = Color(0xFF0DC0DE);
  static const Color darkBlueColor = Color(0xFF103C4A);
  static const Color blueColor = Color(0xFF0DC0DE);
  static const Color whiteOrangeColor = Color(0xFFF8C89A);
  static const Color pinkColor = Color(0xFFFA9BB1);
  static const Color vegColor = Color(0xFF03A100);
  static const Color nonVegColor = Color(0xFFA10000);
  static Color greyColor = Colors.grey.shade400;
  static const Color lightBG = Color(0xFFF5F3EE);
  static const Color darkBG = Color(0xFF18191A);
  static const LinearGradient linearGradientSecondary = LinearGradient(
    colors: [
      Color(0xFFE9455D),
      Color(0xFFFA9BB1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient linearGradientPink = LinearGradient(
    colors: [
      Color(0xFFFA9BB1),
      Color(0xFFF8C89A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient linearGradientWhiteOrange =  LinearGradient(
    colors: [
      Color(0xFFF8C89A),
      Color(0xFFF8C89A),
      Color(0xFFF3FAFF),
    ],
    stops: [0.0, 0.0001, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient linearGradientBlue =  LinearGradient(
    colors: [
      Color(0xFF0DC0DE),
      Color(0xFFF8C89A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient linearGradientDarkBlue =  LinearGradient(
    colors: [
      Color(0xFF103C4A),
      Color(0xFF0DC0DE),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient linearGradientLightTheme =  LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.bottomRight,
    colors: [
      Color(0xFF00FF47), // equivalent to #00FF47
      Color(0xFFFFFFFF), // equivalent to #FFFFFF
    ],
    stops: [
      0.0, // equivalent to 0%
      1.0, // equivalent to 100%
    ],
  );
  static const LinearGradient linearGradientDarkTheme =  LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.bottomRight,
    colors: [
      Color(0xFF000000), // equivalent to #000000
      Color(0xFF001B79), // equivalent to #001B79
    ],
    stops: [
      -0.0563, // equivalent to -5.63%
      1.0, // equivalent to 100%
    ],
  );
}
