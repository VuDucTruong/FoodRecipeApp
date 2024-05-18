import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_food_title.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class RecipeItem extends StatelessWidget {
  RecipeItem({Key? key, required this.isUser, required this.recipe})
      : super(key: key);
  bool isUser;
  RecipeEntity recipe;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m4, horizontal: AppMargin.m12),
      child: Stack(
        children: [
          Container(
            height: AppSize.s200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      recipe.attachmentUrls[recipe.representIndex]),
                  onError: (exception, stackTrace) =>
                      const AssetImage(PicturePath.errorImagePath),
                ),
                borderRadius: BorderRadius.circular(AppRadius.r20)),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: UserFoodTitle(
                like: recipe.likes,
                foodName: recipe.title,
                width: MediaQuery.of(context).size.width * 0.8,
              )),
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
}
