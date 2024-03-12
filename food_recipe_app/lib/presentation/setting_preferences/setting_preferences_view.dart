import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_recipe_app/presentation/common/widgets/widget.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../common/custom_path.dart';
import '../resources/font_manager.dart';
import '../resources/value_manament.dart';

class SettingPreferencesView extends StatefulWidget {
  const SettingPreferencesView({super.key});

  @override
  _SettingPreferencesViewState createState() {
    return _SettingPreferencesViewState();
  }
}

class _SettingPreferencesViewState extends State<SettingPreferencesView> {
  List<String> countryList = [
    "Vietnam",
    "India",
    "China",
    "Thailand",
    "Singapore",
    "HongKong",
    "America",
    "England",
    "Turkey",
    "Laos"
  ];

  List<String> typeList = [
    "Healthy",
    "Fast Food",
    "Quick",
    "Cuisine",
    "Breakfast",
    "Snack",
    "Lunch",
    "Dinner",
    "Dessert",
    "Soup",
    "Drink",
    "Traditional"
  ];
  late PageController _pageController;
  Map<int, bool> countryPreferencesMap = {};
  Map<int, bool> typePreferencesMap = {};
  bool isOn = true;
  int pageIndex = 0;
  @override
  void initState() {
    countryPreferencesMap = {
      for (int i = 0; i < countryList.length; i++) i: false
    };
    typePreferencesMap = {for (int i = 0; i < typeList.length; i++) i: false};
    _pageController = PageController();

    super.initState();
  }

  late List<Widget> pages = [_getFoodCountry(), _getFoodType()];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m6),
          child: SingleChildScrollView(
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
                Container(
                    margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
                    child: Text(
                      AppStrings.selectPreferences,
                      style: getSemiBoldStyle(
                          color: ColorManager.secondaryColor,
                          fontSize: FontSize.s20),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.69,
                  child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: pages),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Center(
                    child: FilledButton(
                        onPressed: () {
                          if (pageIndex >= pages.length - 1) return;
                          _pageController.animateToPage(++pageIndex,
                              duration: Durations.short1,
                              curve: Curves.bounceIn);
                        },
                        child: Text(
                          AppStrings.continueOnly,
                          style: getMediumStyle(
                              color: Colors.white, fontSize: FontSize.s20),
                        ))),
                const SizedBox(
                  height: AppSize.s20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFoodCountry() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8, // Khoảng cách giữa các hàng
          // Khoảng cách giữa các cột
          crossAxisSpacing: 16,
          mainAxisExtent: 210),
      itemCount: countryList.length, // Tổng số item
      itemBuilder: (BuildContext context, int index) {
        return _getItemPreference(index);
      },
    );
  }

  Widget _getItemPreference(int index) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          countryPreferencesMap[index] = !countryPreferencesMap[index]!;
        });
      },
      child: AnimatedOpacity(
        duration: Durations.short1,
        opacity: countryPreferencesMap[index] ?? false ? 1 : 0.6,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m3),
            width: 160,
            height: 210,
            child: ClipPath(
              clipper: PreferenceItemPath(),
              child: Container(
                transform: Matrix4.translationValues(0, -5, 0),
                color: ColorManager.whiteOrangeColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      radius: 65,
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      countryList[index],
                      style: getSemiBoldStyle(
                          color: Colors.black, fontSize: FontSize.s20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    gradient: ColorManager.linearGradientDarkBlue,
                    borderRadius: BorderRadius.circular(45)),
              ))
        ]),
      ),
    );
  }

  Widget _getFoodType() {
    double appWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        getLongSwitch(
            AppStrings.veg,
            AppStrings.nonVeg,
            ColorManager.linearGradientLightTheme,
            ColorManager.linearGradientSecondary,
            false,
            appWidth * 0.65,
            40,
            false),
        SizedBox(
          height: 300,
          child: Center(
              child: Wrap(
                  runSpacing: 8,
                  spacing: 16,
                  children: List.generate(
                      typeList.length,
                      (index) => _getFoodItem(
                          appWidth / 2.5, typeList[index], index)))),
        ),
        Row(
          children: [
            Text(
              AppStrings.hungryHeads,
              style:
                  getSemiBoldStyle(color: Colors.black, fontSize: FontSize.s18),
            ),
            const Spacer(),
            _getHeadNumber(),
          ],
        ),
        const SizedBox(
          height: AppSize.s12,
        ),
        Row(
          children: [
            Text(
              AppStrings.newDishNotification,
              style:
                  getSemiBoldStyle(color: Colors.black, fontSize: FontSize.s18),
            ),
            const Spacer(),
            getOnOffSwitch(isOn)
          ],
        ),
      ],
    );
  }

  Widget _getHeadNumber() {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r15),
                color: Colors.grey.shade300),
            width: AppSize.s120,
            height: AppSize.s30,
            child: Center(
              child: Text(
                '2',
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
              ),
            )),
        Positioned(
          left: 0,
          child: Container(
            width: AppSize.s30,
            height: AppSize.s30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: ColorManager.linearGradientPink),
            child: Center(
              child: IconButton(
                  iconSize: AppSize.s16,
                  onPressed: () {},
                  icon: const Icon(Icons.remove)),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: AppSize.s30,
            height: AppSize.s30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r10),
                gradient: ColorManager.linearGradientDarkBlue),
            child: Center(
              child: IconButton(
                  iconSize: AppSize.s16,
                  onPressed: () {},
                  icon: const Icon(Icons.add)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getFoodItem(double width, String foodName, int index) {
    return AnimatedOpacity(
      duration: Durations.medium1,
      opacity: typePreferencesMap[index] ?? false ? 1 : 0.6,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            alignment: Alignment.center,
            width: width,
            height: 35,
            decoration: BoxDecoration(
                color: ColorManager.whiteOrangeColor,
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: width * 0.8,
              child: Text(
                foodName,
                overflow: TextOverflow.clip,
                style: getSemiBoldStyle(
                    color: ColorManager.darkBlueColor, fontSize: FontSize.s18),
              ),
            ),
          ),
          Container(
            width: 13,
            height: 13,
            transform: Matrix4.translationValues(-5, 0, 0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: ColorManager.lightBG,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(AppRadius.r45),
                gradient: ColorManager.linearGradientDarkBlue),
          ),
        ],
      ),
    );
  }
}
