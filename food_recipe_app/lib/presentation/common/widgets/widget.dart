import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless_widget.dart';

import '../../resources/assets_management.dart';
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

Widget getUserSocialStatus() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              '5',
              style: getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
            ),
            const SizedBox(
              height: AppSize.s4,
            ),
            Text(
              AppStrings.recipes,
              style: TextStyle(
                  color: ColorManager.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s16),
            )
          ],
        ),
        Column(
          children: [
            Text('2.8k',
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s16)),
            Text(
              AppStrings.followers,
              style: getBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s16),
            )
          ],
        ),
        Column(
          children: [
            Text('321',
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s16)),
            Text(
              AppStrings.following,
              style: getBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s16),
            )
          ],
        ),
      ],
    ),
  );
}

Container getUserDescription() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
    child: const Text(
        'Hola! I’m Claudia, a passionate chef and a part time designer. I learnt cooking '
        'from my grandmother and mom...'),
  );
}

Widget getUserIntro() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 144,
          width: 144,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(AppRadius.r20)),
        ),
        Container(
          margin: const EdgeInsets.all(AppMargin.m8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.all(AppMargin.m4),
                  child: Text(
                    'Name',
                    style: getBoldStyle(
                        color: Colors.black, fontSize: FontSize.s18),
                  )),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_rounded),
                    const SizedBox(
                      width: AppSize.s8,
                    ),
                    Text('Mexico',
                        style: getRegularStyle(
                            color: Colors.black, fontSize: FontSize.s18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(PicturePath.instagramPath),
                    const SizedBox(
                      width: AppSize.s8,
                    ),
                    Text('@instagram',
                        style: getRegularStyle(
                            color: Colors.black, fontSize: FontSize.s18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(PicturePath.gmailPath),
                    const SizedBox(
                      width: AppSize.s8,
                    ),
                    Text('@gmai.com',
                        style: getRegularStyle(
                            color: Colors.black, fontSize: FontSize.s18))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget getRecipeItem(BuildContext context, bool isUser) {
  return Container(
    margin: const EdgeInsets.symmetric(
        vertical: AppMargin.m4, horizontal: AppMargin.m12),
    child: Stack(
      children: [
        Container(
          height: AppSize.s200,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(AppRadius.r20)),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: getUserFoodTitle(
                MediaQuery.of(context).size.width * 0.8, "Food Name")),
        isUser
            ? Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                      color: ColorManager.darkBlueColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(AppRadius.r15)),
                  child: Column(
                    children: [
                      SvgPicture.asset(PicturePath.deletePath),
                      Text(
                        AppStrings.delete,
                        style: getRegularStyle(
                            color: Colors.white, fontSize: FontSize.s10),
                      )
                    ],
                  ),
                ))
            : Container()
      ],
    ),
  );
}

Widget getUserFoodTitle(double width, String foodName) {
  return Stack(
    alignment: AlignmentDirectional.centerStart,
    children: [
      Container(
        width: width,
        height: 40,
        decoration: BoxDecoration(
            color: ColorManager.darkBlueColor,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(AppRadius.r20),
                bottomLeft: Radius.circular(AppRadius.r6),
                topLeft: Radius.circular(AppRadius.r6))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              foodName,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s20),
            ),
            Row(
              children: [
                SvgPicture.asset(PicturePath.likedPath),
                Text(
                  '1.2k',
                  style: getSemiBoldStyle(
                      color: ColorManager.blueColor, fontSize: FontSize.s20),
                )
              ],
            )
          ],
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
