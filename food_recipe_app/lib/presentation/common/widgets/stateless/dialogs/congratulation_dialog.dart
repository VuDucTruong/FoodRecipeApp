import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class CongratulationDialog extends StatelessWidget {
  const CongratulationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: const BoxDecoration(
            gradient: ColorManager.linearGradientPink,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(LottiePath.completePath,
                width: 186, height: 186, fit: BoxFit.cover),
            Text(
              AppStrings.congratulation,
              style: getBoldStyle(
                  color: ColorManager.darkBlueColor, fontSize: FontSize.s25),
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            Text(
              textAlign: TextAlign.center,
              AppStrings.congratulationMessage,
              style: getSemiBoldStyle(
                  color: ColorManager.darkBlueColor, fontSize: FontSize.s18),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.congratulationBtnMessage,
                  style: getMediumStyle(
                      color: Colors.white, fontSize: FontSize.s20),
                ))
          ],
        ),
      ),
    );
  }
}
