import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/long_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/on_off_switch.dart';

import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../resources/assets_management.dart';
import '../resources/string_management.dart';
import '../resources/value_manament.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(AppMargin.m8),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  AppStrings.settings,
                  style: getBoldStyle(
                      color: ColorManager.secondaryColor,
                      fontSize: FontSize.s20),
                ),
                const Spacer(),
                SvgPicture.asset(
                  PicturePath.logoSVGPath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                )
              ],
            ),
            _getIconText(
                AppStrings.privacy, SvgPicture.asset(PicturePath.privacyPath)),
            Row(children: [
              _getIconText(AppStrings.notifications,
                  SvgPicture.asset(PicturePath.notificationPath)),
              const Spacer(),
              OnOffSwitch()
            ]),
            _getIconText(
                AppStrings.help, SvgPicture.asset(PicturePath.messagesPath)),
            _getIconText(
                AppStrings.about, SvgPicture.asset(PicturePath.aboutPath)),
            const SizedBox(
              height: AppSize.s20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppStrings.theme,
                  style: getRegularStyle(
                      color: Colors.black, fontSize: FontSize.s17),
                ),
                LongSwitch(
                  onContent: AppStrings.light,
                  offContent: AppStrings.dark,
                  onColor: ColorManager.linearGradientLightTheme,
                  offColor: ColorManager.linearGradientDarkTheme,
                  width: 180,
                  height: 30,
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s30,
            ),
            SizedBox(
                width: 200,
                child: FilledButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(AppStrings.saveChanges,
                          style: getMediumStyle(
                              color: Colors.white, fontSize: FontSize.s20)),
                    )))
          ],
        ),
      ),
    );
  }

  Widget _getIconText(String text, Widget icon) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: AppSize.s8,
          ),
          Text(
            text,
            style: getRegularStyle(color: Colors.black, fontSize: FontSize.s17),
          )
        ],
      ),
    );
  }
}
