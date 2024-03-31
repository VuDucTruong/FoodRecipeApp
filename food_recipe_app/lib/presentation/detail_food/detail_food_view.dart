import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../resources/assets_management.dart';
import '../resources/font_manager.dart';
import '../resources/value_manament.dart';

class DetailFoodView extends StatefulWidget {
  const DetailFoodView({super.key});

  @override
  _DetailFoodViewState createState() {
    return _DetailFoodViewState();
  }
}

class _DetailFoodViewState extends State<DetailFoodView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              PicturePath.backArrowPath,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                _getFoodTitle(width, "Food name"),
              ],
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getFoodImage(width),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Text('Ingredients',
                      style: getBoldStyle(
                          color: ColorManager.secondaryColor,
                          fontSize: FontSize.s20)),
                  Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: AppMargin.m8),
                      child: Text(
                        'Ingredient 1\nIngredient 2\nIngredient 3',
                        style: getSemiBoldStyle(
                            color: Colors.black, fontSize: FontSize.s16),
                      )),
                  Text('Instructions',
                      style: getBoldStyle(
                          color: ColorManager.secondaryColor,
                          fontSize: FontSize.s20)),
                  Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: AppMargin.m8),
                      child: Text(
                        'Step 1\nStep 2\nStep 3',
                        style: getRegularStyle(
                            color: Colors.black, fontSize: FontSize.s16),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFoodImage(double width) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: AppSize.s220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r20),
              color: Colors.white),
        ),
        Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.pinkColor.withOpacity(0.6),
              ),
              height: AppSize.s220,
              width: width / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: AppSize.s50,
                    width: AppSize.s50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                        color: Colors.redAccent),
                  ),
                  Text(
                    'Claudia',
                    style: getRegularStyle(
                        color: ColorManager.darkBlueColor,
                        fontSize: FontSize.s15),
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      SvgPicture.asset(
                        PicturePath.timerPath,
                        width: AppSize.s15,
                        height: AppSize.s15,
                        colorFilter: ColorFilter.mode(
                            ColorManager.darkBlueColor, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      Text(
                        '1-2 hours',
                        style: getBoldStyle(
                            color: ColorManager.darkBlueColor,
                            fontSize: FontSize.s14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      SvgPicture.asset(
                        PicturePath.peoplePath,
                        width: AppSize.s15,
                        height: AppSize.s15,
                        colorFilter: ColorFilter.mode(
                            ColorManager.darkBlueColor, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      Text(
                        '2 People',
                        style: getBoldStyle(
                            color: ColorManager.darkBlueColor,
                            fontSize: FontSize.s14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      SvgPicture.asset(
                        PicturePath.likedPath,
                        width: AppSize.s15,
                        height: AppSize.s15,
                        colorFilter: ColorFilter.mode(
                            ColorManager.darkBlueColor, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      Text(
                        '10',
                        style: getBoldStyle(
                            color: ColorManager.darkBlueColor,
                            fontSize: FontSize.s14),
                      )
                    ],
                  ),
                ],
              ),
            )),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p4),
            width: width / 2.5,
            transform: Matrix4.translationValues(0, 32, 0),
            decoration: BoxDecoration(
                color: ColorManager.darkBlueColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadius.r8),
                    bottomRight: Radius.circular(AppRadius.r8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(PicturePath.unlikePath),
                SvgPicture.asset(PicturePath.unsavedPath),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _getFoodTitle(double width, String foodName) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: width * 1.1,
          height: 40,
          decoration: BoxDecoration(
            color: ColorManager.darkBlueColor,
          ),
          child: Center(
            child: Text(
              foodName,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s20),
            ),
          ),
        ),
        Container(
          width: 28,
          height: 28,
          transform: Matrix4.translationValues(-14, 0, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.lightBG,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(AppRadius.r45),
              color: ColorManager.vegColor),
        ),
      ],
    );
  }
}
