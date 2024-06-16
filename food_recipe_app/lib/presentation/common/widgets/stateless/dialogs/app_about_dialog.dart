import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:lottie/lottie.dart';

class AppAboutDialog extends StatelessWidget {
  const AppAboutDialog({super.key});
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
            SvgPicture.asset(
              PicturePath.logoSVGPath,
              width: 70,
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.about.tr(),
                style: getBoldStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.aboutContent.tr(),
                maxLines: 6,
                style: getRegularStyle(fontSize: 14),
              ),
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.ok.tr()))
          ],
        ),
      ),
    );
  }
}
