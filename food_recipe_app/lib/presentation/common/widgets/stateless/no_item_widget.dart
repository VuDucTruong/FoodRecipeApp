import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:lottie/lottie.dart';

class NoItemWidget extends StatelessWidget {
  const NoItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Lottie.asset(LottiePath.emptyPath, width: 60, height: 60),
          Text(
            AppStrings.noItem.tr(),
            style: getLightStyle(color: ColorManager.darkBlueColor)
                .copyWith(fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
