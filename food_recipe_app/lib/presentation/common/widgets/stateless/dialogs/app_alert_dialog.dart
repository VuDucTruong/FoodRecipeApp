import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class AppAlertDialog extends StatelessWidget {
  AppAlertDialog({Key? key, required this.content}) : super(key: key);
  String content;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: AppStrings.warningMessage,
                      style: getBoldStyle(
                          color: Colors.white, fontSize: FontSize.s18)),
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
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      AppStrings.yes,
                      style: getMediumStyle(
                          color: Colors.white, fontSize: FontSize.s20),
                    )),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
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
}
