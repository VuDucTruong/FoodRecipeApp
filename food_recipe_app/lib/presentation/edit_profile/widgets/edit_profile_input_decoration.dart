import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

InputDecoration editProfileInputDecoration() {
  return InputDecoration(
    isDense: true,
    errorStyle: getRegularStyle(color: Colors.red),
    contentPadding: EdgeInsets.zero,
    enabledBorder: const UnderlineInputBorder(),
    // focused border
    focusedBorder: const UnderlineInputBorder(),

    // error border
    errorBorder: const UnderlineInputBorder(),
    // focused error border
    focusedErrorBorder: const UnderlineInputBorder(),
  );
}
