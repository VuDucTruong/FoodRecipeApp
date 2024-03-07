import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless_widget.dart';

import '../../resources/color_management.dart';
import '../../resources/font_manager.dart';
import '../../resources/string_management.dart';
import '../../resources/style_management.dart';
import '../../resources/value_manament.dart';

Widget getLongSwitch(String onContent, String offContent, Gradient onColor,
    Gradient offColor, bool isOn, double width, double height) {
  return Stack(
    textDirection: TextDirection.ltr,
    alignment: AlignmentDirectional.centerStart,
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              height,
            ),
            gradient: isOn ? onColor : offColor),
      ),
      Positioned(
        left: 5,
        child: AnimatedOpacity(
          opacity: isOn ? 1 : 0,
          duration: Durations.medium2,
          child: GradientText(
            AppStrings.light,
            gradient: ColorManager.linearGradientBlue,
            style:
                getSemiBoldStyle(color: Colors.black, fontSize: FontSize.s20),
          ),
        ),
      ),
      Positioned(
        right: 5,
        child: AnimatedOpacity(
          opacity: isOn ? 0 : 1,
          duration: Durations.medium2,
          child: GradientText(
            AppStrings.dark,
            gradient: ColorManager.linearGradientBlue,
            style:
                getSemiBoldStyle(color: Colors.black, fontSize: FontSize.s20),
          ),
        ),
      ),
      AnimatedPositioned(
        duration: Durations.medium2,
        curve: Curves.decelerate,
        left: isOn ? width - height : 0,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
                border: Border.all(
                    color: isOn ? Colors.white : Colors.black,
                    width: height / 4),
                color: isOn ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(45)),
          ),
        ),
      ),
    ],
  );
}

Container getFoodTypeList() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
    height: AppSize.s30,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red, width: 1)),
          child: const Text(
            'Healthy',
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    ),
  );
}
