import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../../resources/assets_management.dart';

class ChefBackground extends StatefulWidget {
  const ChefBackground({super.key, required this.recipeId});
  final String recipeId;

  @override
  State<ChefBackground> createState() => _ChefBackgroundState();
}

class _ChefBackgroundState extends State<ChefBackground> {
  bool isLike = false, isSaved = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              setState(() {
                isLike = !isLike;
              });
            },
            child: isLike
                ? SvgPicture.asset(PicturePath.likedPath)
                : SvgPicture.asset(PicturePath.unlikePath),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  isSaved = !isSaved;
                });
              },
              child: isSaved
                  ? SvgPicture.asset(PicturePath.savedPath)
                  : SvgPicture.asset(PicturePath.unsavedPath)),
        ],
      ),
    );
  }
}
