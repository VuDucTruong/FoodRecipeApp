import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/long_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/on_off_switch.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/default_heads.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/widgets/food_item.dart';

class SettingFoodTypeView extends StatefulWidget {
  const SettingFoodTypeView({super.key});

  @override
  State<SettingFoodTypeView> createState() => _SettingFoodTypeViewState();
}

class _SettingFoodTypeViewState extends State<SettingFoodTypeView> {
  List<String> typeList = Constant.typeList;
  Map<String, bool> typePreferencesMap = {};
  MutableVariable<int> headNumber = MutableVariable(2);
  MutableVariable<bool> isVeg = MutableVariable(true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typePreferencesMap = {
      for (int i = 0; i < typeList.length; i++) typeList[i]: false
    };
  }

  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Text(
                  AppStrings.setUpKitchen,
                  style:
                      getBoldStyle(color: Colors.black, fontSize: FontSize.s20),
                ),
              ),
              Row(
                children: [
                  Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: AppMargin.m8),
                      child: Text(
                        AppStrings.selectPreferences,
                        style: getSemiBoldStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: FontSize.s20),
                      )),
                ],
              ),
              Center(
                child: LongSwitch(
                  onContent: AppStrings.veg,
                  offContent: AppStrings.nonVeg,
                  onColor: ColorManager.linearGradientLightTheme,
                  offColor: ColorManager.linearGradientNonVeg,
                  width: appWidth * 0.65,
                  height: 40,
                ),
              ),
              _buildTypeList(appWidth),
              Row(
                children: [
                  Text(
                    AppStrings.hungryHeads,
                    style: getSemiBoldStyle(
                        color: Colors.black, fontSize: FontSize.s18),
                  ),
                  const Spacer(),
                  DefaultHeads(
                    headNumber: headNumber,
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Row(
                children: [
                  Text(
                    AppStrings.newDishNotification,
                    style: getSemiBoldStyle(
                        color: Colors.black, fontSize: FontSize.s18),
                  ),
                  const Spacer(),
                  OnOffSwitch(
                    isOn: isVeg,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FilledButton(
                    onPressed: () {
                      int count = 0;
                      for (var element in typePreferencesMap.values) {
                        if (element) count++;
                      }
                      if (count <= 3) {
                        print('Fail  qua it');
                      } else {
                        print('OK');
                      }
                      /*if (typePreferencesMap.values
                              .map((e) => e == true)
                              .toList()
                              .length <=
                          3) {
                        print(typePreferencesMap);
                      } else {
                        print('OK thanh cong');
                      }*/
                      /*if (pageIndex >= pages.length - 1) {
                              return;
                            }
                            _pageController.jumpToPage(++pageIndex);*/
                    },
                    child: Text(
                      AppStrings.continueOnly,
                      style: getMediumStyle(
                          color: Colors.white, fontSize: FontSize.s20),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildTypeList(double appWidth) {
    return SizedBox(
      height: 300,
      child: Center(
          child: Wrap(
              runSpacing: 8,
              spacing: 16,
              children: List.generate(
                  typeList.length,
                  (index) => FoodItem(
                        width: appWidth / 2.5,
                        foodTypeMap: typePreferencesMap,
                        foodName: typeList[index],
                      )))),
    );
  }
}
