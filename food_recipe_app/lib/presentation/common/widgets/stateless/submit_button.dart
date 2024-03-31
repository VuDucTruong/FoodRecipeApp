import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';

class SubmitButton extends StatelessWidget {
  String text;
  SubmitButton({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: ColorManager.blueColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: ColorManager.darkBlueColor,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
