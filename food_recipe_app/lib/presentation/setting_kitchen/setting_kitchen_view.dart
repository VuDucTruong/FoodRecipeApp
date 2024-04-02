import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/long_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/on_off_switch.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../common/helper/custom_path.dart';
import '../resources/font_manager.dart';
import '../resources/value_manament.dart';
import 'create_profile/create_profile_view.dart';
import 'food_type/setting_food_type_view.dart';

class SettingKitchenView extends StatefulWidget {
  const SettingKitchenView({super.key});

  @override
  _SettingKitchenViewState createState() {
    return _SettingKitchenViewState();
  }
}

class _SettingKitchenViewState extends State<SettingKitchenView> {
  late PageController _pageController;

  bool isOn = true;
  int pageIndex = 0;
  List<Widget> pages = [const SettingFoodTypeView(), const CreateProfileView()];
  @override
  void initState() {
    _pageController = PageController(keepPage: false, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: Text(
                    AppStrings.setUpKitchen,
                    style: getBoldStyle(
                        color: Colors.black, fontSize: FontSize.s20),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
              onPressed: () {
                if (pageIndex >= pages.length - 1) {
                  return;
                }
                _pageController.jumpToPage(++pageIndex);
              },
              child: Text(
                AppStrings.continueOnly,
                style:
                    getMediumStyle(color: Colors.white, fontSize: FontSize.s20),
              )),
          const SizedBox(
            height: 8,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
