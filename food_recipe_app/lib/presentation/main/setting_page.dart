import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/language/language_cubit.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/long_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/on_off_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_about_dialog.dart';

import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/language_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';

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
  final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    isNotification.value = _appPreferences.getIsNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  MutableVariable<bool> isNotification = MutableVariable(false);

  MutableVariable<bool> isLightTheme = MutableVariable(true);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                AppStrings.settings.tr(),
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s20),
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
          const SizedBox(
            height: 24,
          ),
          Row(children: [
            _getIconText(AppStrings.notifications.tr(),
                SvgPicture.asset(PicturePath.notificationPath)),
            const Spacer(),
            OnOffSwitch(
              isOn: isNotification,
            )
          ]),
          InkWell(
            onTap: () async {
              await giveFeedback();
            },
            child: _getIconText(AppStrings.help.tr(),
                SvgPicture.asset(PicturePath.messagesPath)),
          ),
          InkWell(
            onTap: () {
              showAnimatedDialog2(context, const AppAboutDialog());
            },
            child: _getIconText(
                AppStrings.about.tr(), SvgPicture.asset(PicturePath.aboutPath)),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppStrings.language.tr(),
                style: getRegularStyle(
                    color: Colors.black, fontSize: FontSize.s17),
              ),
              LongSwitch(
                onChange: () {
                  context.read<LanguageCubit>().changeLanguage(context);
                },
                initialValue:
                    GetIt.instance<AppPreferences>().getAppLanguage() ==
                        LanguageType.Vietnamese.getValue(),
                onContent: AppStrings.vietnamese.tr(),
                offContent: AppStrings.english.tr(),
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
          FilledButton(
              onPressed: () {
                GetIt.instance<AppPreferences>().logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginRoute, ModalRoute.withName(Routes.loginRoute));
              },
              child: Text(AppStrings.signOut.tr(),
                  style: getMediumStyle(
                      color: Colors.white, fontSize: FontSize.s20)))
        ],
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
            text.tr(),
            style: getRegularStyle(color: Colors.black, fontSize: FontSize.s17),
          )
        ],
      ),
    );
  }
}
