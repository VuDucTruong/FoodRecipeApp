import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

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

  Map<int, bool> preferencesMap = {};

  @override
  void initState() {
    preferencesMap = {for (int i = 0; i < countryList.length; i++) i: false};
    super.initState();
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
              Container(
                  margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
                  child: Text(
                    AppStrings.selectPreferences,
                    style: getSemiBoldStyle(
                        color: ColorManager.secondaryColor,
                        fontSize: FontSize.s20),
                  )),
              Expanded(
                child: GridView.builder(
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
                ),
              ),
              Center(
                  child: FilledButton(
                      onPressed: () {},
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
    );
  }

  Widget _getItemPreference(int index) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          preferencesMap[index] = !preferencesMap[index]!;
        });
      },
      child: AnimatedOpacity(
        duration: Durations.short1,
        opacity: preferencesMap[index] ?? false ? 1 : 0.6,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m3),
            width: 160,
            height: 210,
            child: ClipPath(
              clipper: MyPath(),
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
}

class MyPath extends CustomClipper<Path> {
  double curve;
  double gap;

  MyPath({this.curve = 30, this.gap = 10});

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.moveTo(0, curve);

    path.quadraticBezierTo(0, 0, curve, 0);
    path.lineTo(size.width - curve, 0);
    path.quadraticBezierTo(size.width, 0, size.width, curve);

    path.lineTo(size.width, size.height - curve);
    path.quadraticBezierTo(
        size.width, size.height, size.width - curve, size.height - curve / 2);
    path.lineTo(size.width / 2 + gap, size.height - curve);
    path.quadraticBezierTo(
        size.width / 2,
        size.height - gap * tan(pi / 6) - curve,
        size.width / 2 - gap,
        size.height - curve);
    path.lineTo(curve, size.height - curve / 2);
    path.quadraticBezierTo(0, size.height, 0, size.height - curve);
    //path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
