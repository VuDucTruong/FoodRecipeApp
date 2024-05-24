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
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.regular, color);
}

TextStyle getRegularStyleWithUnderline(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.regular, color)
      .copyWith(decoration: TextDecoration.underline);
}
// light text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.bold, color);
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.medium, color);
}
