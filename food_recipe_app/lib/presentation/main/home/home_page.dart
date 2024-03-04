import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/detail_food/detail_food_view.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../../chef_profile/chef_profile_view.dart';
import '../../common/widgets/widget.dart';
import '../../resources/font_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getSlogan(),
              _getSearchBar(),
              const SizedBox(
                height: AppSize.s20,
              ),
              _getHeadingHome(AppStrings.trendingToday),
              _getCarouselSlider(),
              _getHeadingHome(AppStrings.categories),
              _getFoodTypeList(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
                height: AppSize.s175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppMargin.m4),
                        child: _getFoodItem());
                  },
                ),
              ),
              _getHeadingHome(AppStrings.verifiedChefs),
              _getChefList(),
              const SizedBox(
                height: AppSize.s8,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _getChefList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      height: AppSize.s130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: AppMargin.m8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.chefProfileRoute);
              },
              child: Column(
                children: [
                  Container(
                    height: AppSize.s80,
                    width: AppSize.s80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                        color: Colors.amber),
                  ),
                  Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
                    child: const Text(
                      'Name Chefs',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _getFoodTypeList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
      height: AppSize.s30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red, width: 1)),
            child: const Text(
              'Healthy',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }

  Container _getCarouselSlider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: CarouselSlider(
        options: CarouselOptions(
          height: AppSize.s150,
          autoPlay: true,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text $i',
                    style: const TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }

  Container _getSlogan() {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m4, bottom: AppMargin.m8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.homeTitle,
            style: getBoldStyle(
                color: ColorManager.secondaryColor, fontSize: FontSize.s20),
          ),
          SvgPicture.asset(
            PicturePath.logoSVGPath,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }

  Widget _getHeadingHome(String content) {
    return Row(
      children: [
        Text(
          content,
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s18),
        ),
        const Spacer(),
        Text(
          AppStrings.seeAll,
          style: getRegularStyleWithUnderline(
              color: Colors.grey, fontSize: FontSize.s15),
        ),
      ],
    );
  }

  Widget _getFoodItem() {
    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, Routes.detailFoodRoute)},
      child: Container(
          width: AppSize.s100,
          height: AppSize.s175,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.r50),
                  bottom: Radius.circular(AppRadius.r18)),
              gradient: ColorManager.linearGradientPink),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: AppRadius.r50,
                backgroundColor: Colors.amber,
                //backgroundImage: AssetImage(PicturePath.fbPath),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timelapse_sharp, size: AppSize.s12),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          Text('10-20 mins',
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s8))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.people, size: AppSize.s12),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('4-5 people',
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s8))
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsets.symmetric(vertical: AppMargin.m4),
                        width: AppSize.s90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Gergous',
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: FontSize.s10),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(Icons.account_box_rounded,
                                size: AppSize.s12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              getTitleFoodName(MediaQuery.of(context).size.width, 25, 10,
                  ColorManager.darkBlueColor, FontSize.s12)
            ],
          )),
    );
  }

  Widget _getSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
      child: Material(
          elevation: 8,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(AppRadius.r15),
          child: Form(
            child: TextFormField(
                decoration: InputDecoration(
              suffixIcon: SvgPicture.asset(
                PicturePath.searchPath,
                fit: BoxFit.none,
              ),
            )),
          )),
    );
  }
}
