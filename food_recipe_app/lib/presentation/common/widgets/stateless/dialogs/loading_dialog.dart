import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(LottiePath.loadingPath,
              width: 60, height: 60, fit: BoxFit.cover),
          Text(AppStrings.loading.tr(),
              style: getMediumStyle(
                  color: ColorManager.whiteOrangeColor,
                  fontSize: FontSize.s18)),
          const SizedBox(
            height: AppSize.s12,
          ),
        ],
      ),
    );
  }
}
