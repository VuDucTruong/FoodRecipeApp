import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/widget.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';

class SavedRecipePage extends StatefulWidget {
  const SavedRecipePage({super.key});

  @override
  _SavedRecipePageState createState() {
    return _SavedRecipePageState();
  }
}

class _SavedRecipePageState extends State<SavedRecipePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width * 0.8;
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
            child: Row(
              children: [
                Text(
                  AppStrings.savedRecipes,
                  style: getBoldStyle(
                      color: ColorManager.secondaryColor,
                      fontSize: FontSize.s20),
                ),
                const Spacer(),
                SvgPicture.asset(
                  PicturePath.logoSVGPath,
                  width: AppSize.s50,
                  height: AppSize.s50,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          getFoodTypeList(),
          const SizedBox(
            height: AppSize.s10,
          ),
          ListView.builder(
              itemCount: 20,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
<<<<<<< Updated upstream
                return Center(
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: AppMargin.m12),
                        width: width,
                        height: 190,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Positioned(
                        bottom: 0,
                        child: getTitleFoodName(width - 10, 40, 15,
                            ColorManager.darkBlueColor, FontSize.s20),
                      ),
                    ],
                  ),
                );
=======
                return Center(child: getRecipeItem(context, true));
>>>>>>> Stashed changes
              }),
        ],
      )),
    );
  }
<<<<<<< Updated upstream
=======

  /*Widget _getFoodTitle(double width, String foodName) {
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
          child: Center(
            child: Text(
              foodName,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s20),
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
  }*/
>>>>>>> Stashed changes
}
