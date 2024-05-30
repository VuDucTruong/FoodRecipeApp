import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:get_it/get_it.dart';

import '../../resources/assets_management.dart';

class ChefBackground extends StatefulWidget {
  const ChefBackground({super.key, required this.recipeId});
  final String recipeId;

  @override
  State<ChefBackground> createState() => _ChefBackgroundState();
}

class _ChefBackgroundState extends State<ChefBackground> {
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();
  late bool isLike, isSave;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLike = backgroundUser.likedRecipeIds.contains(widget.recipeId);
    isSave = backgroundUser.savedRecipeIds.contains(widget.recipeId);
  }

  void updateLikeStatus() {
    setState(() {
      if (isLike) {
        backgroundUser.likedRecipeIds.remove(widget.recipeId);
        isLike = false;
      } else {
        backgroundUser.likedRecipeIds.add(widget.recipeId);
        isLike = true;
      }
    });
  }

  void updateSaveStatus() {
    setState(() {
      if (isSave) {
        backgroundUser.savedRecipeIds.remove(widget.recipeId);
        isSave = false;
      } else {
        backgroundUser.savedRecipeIds.add(widget.recipeId);
        isSave = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p4),
      width: MediaQuery.of(context).size.width * 0.8 / 2.5,
      decoration: const BoxDecoration(
          color: ColorManager.darkBlueColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.r8),
              bottomRight: Radius.circular(AppRadius.r8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              updateLikeStatus();
            },
            child: isLike
                ? SvgPicture.asset(PicturePath.likedPath)
                : SvgPicture.asset(PicturePath.unlikePath),
          ),
          InkWell(
              onTap: () {
                updateSaveStatus();
              },
              child: isSave
                  ? SvgPicture.asset(PicturePath.savedPath)
                  : SvgPicture.asset(PicturePath.unsavedPath)),
        ],
      ),
    );
  }
}
