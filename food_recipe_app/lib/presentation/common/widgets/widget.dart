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

Widget getTitleFoodName(double width, double height, double dotRadius,
    Color color, double fontSize) {
  return Stack(
    alignment: Alignment.centerRight,
    children: [
      Container(
        margin: const EdgeInsets.only(left: AppMargin.m11),
        width: width,
        height: height,
        child: ClipPath(
          clipper: _MyPath(),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                'Food name',
                style: getBoldStyle(color: Colors.white, fontSize: fontSize),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 6,
        child: Container(
          width: dotRadius,
          height: dotRadius,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dotRadius),
              color: ColorManager.vegColor),
        ),
      ),
    ],
  );
}

class _MyPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01485720, size.height * 0.2395840);
    path_0.cubicTo(size.width * -0.003681448, size.height * 0.1854327,
        size.width * 0.002089272, 0, size.width * 0.02231313, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.4974975);
    path_0.cubicTo(
        size.width,
        size.height * 0.7736400,
        size.width * 0.9665896,
        size.height * 0.9974975,
        size.width * 0.9253731,
        size.height * 0.9974975);
    path_0.lineTo(size.width * 0.02231310, size.height * 0.9974975);
    path_0.cubicTo(
        size.width * 0.002089265,
        size.height * 0.9974975,
        size.width * -0.003681511,
        size.height * 0.8120650,
        size.width * 0.01485713,
        size.height * 0.7579150);
    path_0.lineTo(size.width * 0.02512664, size.height * 0.7279175);
    path_0.cubicTo(
        size.width * 0.05499515,
        size.height * 0.6406725,
        size.width * 0.05499515,
        size.height * 0.3568275,
        size.width * 0.02512672,
        size.height * 0.2695825);
    path_0.lineTo(size.width * 0.01485720, size.height * 0.2395840);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

Widget getLongSwitch(String onContent, String offContent, Gradient onColor,
    Gradient offColor, bool isOn, double width, double height) {
  return Center(
    child: Stack(
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
    ),
  );
}
