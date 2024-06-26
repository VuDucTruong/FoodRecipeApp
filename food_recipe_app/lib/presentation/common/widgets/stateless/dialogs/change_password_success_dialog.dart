import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class ChangePasswordSuccessDialog extends StatelessWidget {
  ChangePasswordSuccessDialog(
      {Key? key, this.content = AppStrings.congratulationMessage})
      : super(key: key);
  String content;
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
            Lottie.asset(LottiePath.changePassSuccessPath,
                width: 186, height: 186, fit: BoxFit.cover),
            Text(
              textAlign: TextAlign.center,
              maxLines: 3,
              content,
              style: getSemiBoldStyle(
                  color: ColorManager.darkBlueColor, fontSize: FontSize.s18),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  AppStrings.congratulationBtnMessage.tr(),
                  style: getMediumStyle(
                      color: Colors.white, fontSize: FontSize.s20),
                ))
          ],
        ),
      ),
    );
  }
}
