import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/di.dart';

import 'package:food_recipe_app/presentation/main/create_recipe/create_recipe_page.dart';
import 'package:food_recipe_app/presentation/main/home/home_page.dart';
import 'package:food_recipe_app/presentation/main/saved_recipe_page.dart';
import 'package:food_recipe_app/presentation/main/setting_page.dart';
import 'package:food_recipe_app/presentation/main/user_profile_page.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/value_manament.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int index = 2;
  List<Widget> pages = [
    const CreateRecipePage(),
    const SavedRecipePage(),
    const HomePage(),
    const SettingPage(),
    const UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: const BoxDecoration(
              gradient: ColorManager.linearGradientSecondary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getAnimatedBarItem(0, PicturePath.createPath),
              _getAnimatedBarItem(1, PicturePath.savePath),
              _getAnimatedBarItem(2, PicturePath.homePath),
              _getAnimatedBarItem(3, PicturePath.settingPath),
              _getAnimatedBarItem(4, PicturePath.profilePath),
            ],
          ),
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            switch (index) {
              case 0:
                initCreateRecipeModule();
                break;
              case 1:
                initSavedRecipeModule();
                break;
              case 2:
                initHomeModule();
                break;
              case 3:
                break;
              case 4:
                initUserProfileModule();
                break;
            }
            return pages[index];
          }),
        ));
  }

  Widget _getAnimatedBarItem(int x, String picturePath) {
    return InkWell(
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        transform: Matrix4.translationValues(0, index == x ? -20 : 0, 0),
        duration: Durations.medium1,
        curve: Curves.decelerate,
        child: Container(
            padding: const EdgeInsets.all(AppPadding.p4),
            decoration: index == x
                ? const BoxDecoration(
                    gradient: ColorManager.linearGradientPink,
                    shape: BoxShape.circle)
                : null,
            child: SvgPicture.asset(
              height: 35,
              width: 35,
              picturePath,
              colorFilter: index == x
                  ? const ColorFilter.mode(
                      ColorManager.darkBlueColor, BlendMode.srcIn)
                  : null,
            )),
      ),
      onTap: () {
        if (index == x) return;
        setState(() {
          index = x;
        });
      },
    );
  }
}
