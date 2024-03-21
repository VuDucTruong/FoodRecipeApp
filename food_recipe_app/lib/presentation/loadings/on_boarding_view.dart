import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  OnBoardingViewState createState() => OnBoardingViewState();
}

class OnBoardingViewState extends State<OnBoardingView> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<OnBoardingObject> _boardingItemList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _boardingItemList = [
      OnBoardingObject(
        imageProvider: const AssetImage(PicturePath.onBoarding1Path),
        title: AppStrings.onBoardingTitle1,
        description: AppStrings.onBoardingDescription1,
      ),
      OnBoardingObject(
        imageProvider: const AssetImage(PicturePath.onBoarding2Path),
        title: AppStrings.onBoardingTitle2,
        description: AppStrings.onBoardingDescription2,
      ),
      OnBoardingObject(
        imageProvider: const AssetImage(PicturePath.onBoarding3Path),
        title: AppStrings.onBoardingTitle3,
        description: AppStrings.onBoardingDescription3,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _boardingItemList.length,
            itemBuilder: (context, index) {
              return _getBoardingItem(_boardingItemList[index]);
            },
          ),
          Positioned(
            bottom: 10,
            child: Column(
              children: [
                Row(
                  children: [
                    ...List.generate(_boardingItemList.length,
                        (index) => _getIndicator(index)),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                _getContinueButton(),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.signUpRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: getSemiBoldStyle(
                            color: Colors.white, fontSize: FontSize.s16)
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _getContinueButton({String text = AppStrings.continueOnly}) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: ColorManager.blueColor),
      onPressed: () {
        if (_selectedIndex < _boardingItemList.length - 1) {
          setState(() {
            _pageController.animateToPage(++_selectedIndex,
                duration: Durations.medium2, curve: Curves.ease);
          });
        } else {
          Navigator.pushReplacementNamed(context, Routes.signUpRoute);
        }
      },
      child: Text(
        text,
        style: getMediumStyle(
            color: ColorManager.darkBlueColor, fontSize: FontSize.s20),
      ),
    );
  }

  Widget _getIndicator(int index) {
    return AnimatedContainer(
      duration: Durations.medium2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _selectedIndex == index ? 24 : 14,
      decoration: BoxDecoration(
        gradient:
            _selectedIndex == index ? ColorManager.linearGradientPink : null,
        color: ColorManager.greyColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _getBoardingItem(OnBoardingObject item) {
    return Stack(
      alignment: FractionalOffset.center,
      children: [
        Image(
          image: item.imageProvider,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: Colors.black.withOpacity(0.3),
          width: double.infinity,
          height: double.infinity,
        ), // Tao effect cho screen toi di
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          child: SvgPicture.asset(
            PicturePath.logoSVGPath,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.2,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "${item.title} \n",
                    style: getMediumStyle(
                        color: Colors.white, fontSize: FontSize.s38)),
                TextSpan(
                    text: item.description,
                    style: getMediumStyle(
                        color: ColorManager.whiteOrangeColor,
                        fontSize: FontSize.s38)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnBoardingObject {
  ImageProvider imageProvider;
  String title, description;

  OnBoardingObject(
      {required this.imageProvider,
      required this.title,
      required this.description});
}
