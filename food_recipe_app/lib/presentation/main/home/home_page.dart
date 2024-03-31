import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/food_type_list.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

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
              const FoodTypeList(),
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
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _getFoodTitle(AppSize.s100 - 15, "Food name"),
                ],
              )
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

  Widget _getFoodTitle(double width, String foodName) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: width,
          height: 25,
          decoration: const BoxDecoration(
              color: ColorManager.darkBlueColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppRadius.r18),
                  bottomLeft: Radius.circular(AppRadius.r6),
                  topLeft: Radius.circular(AppRadius.r6))),
          child: Center(
            child: Text(
              foodName,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s12),
            ),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          transform: Matrix4.translationValues(-5, 0, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.pinkColor,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(AppRadius.r45),
              color: ColorManager.vegColor),
        ),
      ],
    );
  }
}
