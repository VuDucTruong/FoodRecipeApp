import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

import '../../resources/font_manager.dart';
import '../../resources/string_management.dart';

Widget getCongratulationDialog(BuildContext context) {
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
                style:
                    getMediumStyle(color: Colors.white, fontSize: FontSize.s20),
              ))
        ],
      ),
    ),
  );
}

Widget getAlertDialog(BuildContext context, String content) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      decoration: const BoxDecoration(
          color: ColorManager.darkBlueColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(LottiePath.exclamationPath,
              width: 60, height: 60, fit: BoxFit.cover),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: AppStrings.warningMessage,
                style:
                    getBoldStyle(color: Colors.white, fontSize: FontSize.s18)),
            TextSpan(
                text: content,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor,
                    fontSize: FontSize.s20)),
          ])),
          const SizedBox(
            height: AppSize.s12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.yes,
                    style: getMediumStyle(
                        color: Colors.white, fontSize: FontSize.s20),
                  )),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.no,
                    style: getMediumStyle(
                        color: Colors.white, fontSize: FontSize.s20),
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget getNoConnectionDialog(BuildContext context) {
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
                style:
                    getMediumStyle(color: Colors.white, fontSize: FontSize.s20),
              ))
        ],
      ),
    ),
  );
}
