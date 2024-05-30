import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/detail_recipe/bloc/detail_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/detail_recipe/bloc/detail_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';

import 'chef_background.dart';

class RecipeImage extends StatefulWidget {
  const RecipeImage({super.key, required this.recipeEntity, this.chefEntity});
  final RecipeEntity recipeEntity;
  final ChefEntity? chefEntity;

  @override
  State<RecipeImage> createState() => _RecipeImageState();
}

class _RecipeImageState extends State<RecipeImage> {
  DetailRecipeBloc detailRecipeBloc = GetIt.instance<DetailRecipeBloc>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width * 0.8;
    return BlocListener<DetailRecipeBloc, DetailRecipeState>(
      bloc: detailRecipeBloc,
      listener: (context, state) {
        if (state is RecipeLikeSuccessState) {
          setState(() {
            widget.recipeEntity.likes += state.isLike ? 1 : -1;
          });
        }
        if (state is RecipeSaveSuccessState) {
          if(state.isSave) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.saveSucccess)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.unSaveSuccess)));
          }
        }
        if (state is RecipeLikeFailState || state is RecipeSaveFailState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(AppStrings.somethingWentWrong),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Stack(
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
                    image: NetworkImage(widget.recipeEntity
                        .attachmentUrls[widget.recipeEntity.representIndex])),
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
                                image: widget.chefEntity != null
                                    ? NetworkImage(widget.chefEntity
                                            ?.profileInfo.avatarUrl ??
                                        '')
                                    : const AssetImage(
                                            PicturePath.errorImagePath)
                                        as ImageProvider,
                                onError: (exception, stackTrace) =>
                                    const AssetImage(
                                        PicturePath.errorImagePath),
                              )),
                        ),
                        Text(
                          widget.chefEntity?.profileInfo.fullName ??
                              AppStrings.notFound,
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
                              '${widget.recipeEntity.cookTime} ${AppStrings.minutes}',
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
                              '${widget.recipeEntity.serves} ${AppStrings.people}',
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
                              '${widget.recipeEntity.likes}',
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
                    recipeId: widget.recipeEntity.id,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
