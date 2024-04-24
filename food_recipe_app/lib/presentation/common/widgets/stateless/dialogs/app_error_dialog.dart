import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class AppErrorDialog extends StatelessWidget {
  AppErrorDialog({Key? key, required this.content}) : super(key: key);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(LottiePath.exclamationPath,
                width: 60, height: 60, fit: BoxFit.cover),
            Text(content,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor,
                    fontSize: FontSize.s20)),
            const SizedBox(
              height: AppSize.s12,
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.ok,
                  style: getMediumStyle(
                      color: Colors.white, fontSize: FontSize.s20),
                )),
          ],
        ),
      ),
    );
  }
}
