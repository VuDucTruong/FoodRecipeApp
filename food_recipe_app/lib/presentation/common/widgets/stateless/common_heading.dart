import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class CommonHeading extends StatelessWidget {
  const CommonHeading({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style:
            getSemiBoldStyle(fontSize: 16, color: ColorManager.darkBlueColor),
      ),
    );
  }
}
