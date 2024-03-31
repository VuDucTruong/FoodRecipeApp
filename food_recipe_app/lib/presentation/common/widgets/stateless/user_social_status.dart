import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserSocialStatus extends StatelessWidget {
  const UserSocialStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '5',
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
              ),
              const SizedBox(
                height: AppSize.s4,
              ),
              Text(
                AppStrings.recipes,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s16),
              )
            ],
          ),
          Column(
            children: [
              Text('2.8k',
                  style: getBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16)),
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
                  style: getBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16)),
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
}
