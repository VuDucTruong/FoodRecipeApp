import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import 'chef_background.dart';

class RecipeImage extends StatelessWidget {
  const RecipeImage({super.key, required this.recipeEntity, this.chefEntity});
  final RecipeEntity recipeEntity;
  final ChefEntity? chefEntity;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width * 0.8;
    return Stack(
      children: [
        const SizedBox(
          height: 220 + 40,
          width: double.infinity,
        ),
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(-1, 0),
                  blurRadius: 0.5,
                )
              ],
              image: DecorationImage(
                  image: NetworkImage(recipeEntity
                      .attachmentUrls[recipeEntity.representIndex])),
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              color: Colors.white),
        ),
        Positioned(
            right: 0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.pinkColor.withOpacity(0.6),
                  ),
                  height: 220,
                  width: width / 2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: ColorManager.lightBG.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: chefEntity != null
                                  ? NetworkImage(
                                      chefEntity?.profileInfo.avatarUrl ?? '')
                                  : const AssetImage(PicturePath.errorImagePath)
                                      as ImageProvider,
                              onError: (exception, stackTrace) =>
                                  const AssetImage(PicturePath.errorImagePath),
                            )),
                      ),
                      Text(
                        chefEntity?.profileInfo.fullName ?? AppStrings.notFound,
                        style: getRegularStyle(
                            color: ColorManager.darkBlueColor, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(
                            PicturePath.timerPath,
                            width: 15,
                            height: 15,
                            colorFilter: const ColorFilter.mode(
                                ColorManager.darkBlueColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${recipeEntity.cookTime} ${AppStrings.minutes}',
                            style: getBoldStyle(
                                color: ColorManager.darkBlueColor,
                                fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(
                            PicturePath.peoplePath,
                            width: 15,
                            height: 15,
                            colorFilter: const ColorFilter.mode(
                                ColorManager.darkBlueColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${recipeEntity.serves} ${AppStrings.people}',
                            style: getBoldStyle(
                                color: ColorManager.darkBlueColor,
                                fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(
                            PicturePath.likedPath,
                            width: 15,
                            height: 15,
                            colorFilter: const ColorFilter.mode(
                                ColorManager.darkBlueColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${recipeEntity.likes}',
                            style: getBoldStyle(
                                color: ColorManager.darkBlueColor,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                ChefBackground(
                  recipeId: recipeEntity.id,
                )
              ],
            )),
      ],
    );
  }
}
