import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserFoodTitle extends StatelessWidget {
  double width;
  String foodName;
  int like;
  UserFoodTitle(
      {Key? key,
      required this.width,
      required this.foodName,
      required this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: width,
          height: 40,
          decoration: const BoxDecoration(
              color: ColorManager.darkBlueColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppRadius.r20),
                  bottomLeft: Radius.circular(AppRadius.r6),
                  topLeft: Radius.circular(AppRadius.r6))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  foodName,
                  style:
                      getBoldStyle(color: Colors.white, fontSize: FontSize.s20),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 18,
          height: 18,
          transform: Matrix4.translationValues(-5, 0, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.lightBG,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(AppRadius.r45),
              color: ColorManager.vegColor),
        ),
      ],
    );
  }
}
