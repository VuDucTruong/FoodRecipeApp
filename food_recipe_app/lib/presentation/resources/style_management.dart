import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      overflow: TextOverflow.ellipsis);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.regular, color);
}

TextStyle getRegularStyleWithUnderline(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.regular, color)
      .copyWith(decoration: TextDecoration.underline);
}
// light text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.bold, color);
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.medium, color);
}

BoxDecoration getBoxDecorationShadow({BorderRadiusGeometry? borderRadius}){
  return BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius?? BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3), // Shadow color
        spreadRadius: 0, // Spread radius
        blurRadius: 2, // Blur radius
        offset: const Offset(0, 2), // Offset for the shadow (left, top)
      ),
    ],
  );
}