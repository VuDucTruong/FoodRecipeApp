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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(LottiePath.loadingPath,
              width: 60, height: 60, fit: BoxFit.cover),
          Text(AppStrings.loading,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s18)),
          const SizedBox(
            height: AppSize.s12,
          ),
        ],
      ),
    );
  }
}
