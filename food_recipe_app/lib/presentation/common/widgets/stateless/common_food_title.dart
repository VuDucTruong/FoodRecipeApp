import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class CommonFoodTitle extends StatelessWidget {
  CommonFoodTitle(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.fontSize,
      required this.isVegan});
  double height, width;
  String title;
  double fontSize;
  bool isVegan;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              color: ColorManager.darkBlueColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppRadius.r20),
                  bottomLeft: Radius.circular(AppRadius.r6),
                  topLeft: Radius.circular(AppRadius.r6))),
          child: Center(
            child: SizedBox(
              width: width - height,
              child: Text(
                title,
                style: getBoldStyle(color: Colors.white, fontSize: fontSize),
              ),
            ),
          ),
        ),
        Container(
          width: height / 2,
          height: height / 2,
          transform: Matrix4.translationValues(-5, 0, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.lightBG,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(AppRadius.r45),
              color:
                  isVegan ? ColorManager.vegColor : ColorManager.nonVegColor),
        ),
      ],
    );
  }
}
