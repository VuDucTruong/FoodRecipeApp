import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

ThemeData getAppTheme() {
  return ThemeData(
      primaryColor: ColorManager.primaryColor,
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
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: Colors.grey),
        // label style
        labelStyle: getMediumStyle(color: Colors.grey.shade800),
        // error style
        errorStyle: getRegularStyle(color: Colors.red),

        // enabled border
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.primaryColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.primaryColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
