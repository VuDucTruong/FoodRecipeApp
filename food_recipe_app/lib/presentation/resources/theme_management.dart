import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

ThemeData getAppTheme() {
  return ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManager.secondaryColor,
        //showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorManager.darkBlueColor),
    cardTheme: CardTheme(
      color: ColorManager.secondaryColor,
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            backgroundColor: ColorManager.secondaryColor)),
    fontFamily: fontFamily,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.secondaryColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p12),
      // hint style
      hintStyle: getRegularStyle(color: Colors.grey),
      // label style
      labelStyle: getMediumStyle(color: Colors.grey.shade800),
      // error style
      errorStyle: getRegularStyle(color: Colors.red),
      // enabled border
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
      // focused border
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),

      // error border
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
      // focused error border
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
    ),
  );
}
