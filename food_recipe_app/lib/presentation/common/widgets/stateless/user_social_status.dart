import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserSocialStatus extends StatelessWidget {
  const UserSocialStatus({Key? key, required this.entity}) : super(key: key);
  final ChefEntity entity;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        children: [
          Column(
            children: [
              Text(
                entity.recipeIds.length.toString(),
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
              ),
              const SizedBox(
                height: AppSize.s4,
              ),
              Text(
                AppStrings.recipes.tr(),
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s16),
              )
            ],
          ),
          Column(
            children: [
              Text(entity.followerCount.toString(),
                  style: getBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16)),
              Text(
                AppStrings.followers.tr(),
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s16),
              )
            ],
          ),
          Column(
            children: [
              Text(entity.followingCount.toString(),
                  style: getBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16)),
              Text(
                AppStrings.following.tr(),
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
