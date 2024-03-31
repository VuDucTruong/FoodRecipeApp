import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: const BoxDecoration(
            gradient: ColorManager.linearGradientWhiteOrange,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(LottiePath.noConnectionPath,
                width: 100, height: 100, fit: BoxFit.cover),
            Text(
              textAlign: TextAlign.center,
              AppStrings.noInternet,
              style: getBoldStyle(
                  color: ColorManager.darkBlueColor, fontSize: FontSize.s20),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.tryAgain,
                  style: getMediumStyle(
                      color: Colors.white, fontSize: FontSize.s20),
                ))
          ],
        ),
      ),
    );
  }
}
