import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  OnBoardingViewState createState() => OnBoardingViewState();
}

class OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<OnBoardingPage> _boardingPages = [
    // Add your OnBoardingPage objects here
    OnBoardingPage(
      image: const AssetImage(PicturePath.onBoarding1Path),
      title: 'Recipe from all',
      description: 'over the World',
    ),
    OnBoardingPage(
      image: const AssetImage(PicturePath.onBoarding2Path),
      title: 'Recipe with',
      description: 'each and every detail',
    ),
    OnBoardingPage(
      image: const AssetImage(PicturePath.onBoarding3Path),
      title: 'Cook it now or',
      description: 'save it for later',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _boardingPages.length,
          itemBuilder: (context, index) {
            return _boardingPage(_boardingPages[index], index);
          },
        ),
      )),
    );
  }

  Widget _boardingPage(OnBoardingPage page, int index) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: page.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ), // Tao effect cho screen toi di
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SvgPicture.asset(
                  PicturePath.logoSVGPath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Text(
                        page.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: interFontFamily,
                          fontSize: 38,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page.description,
                        style: const TextStyle(
                          color: Color(0xFFF8C89A),
                          fontFamily: interFontFamily,
                          fontSize: 38,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _boardingPages.length,
                          (i) => _indicator(i == index),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _continueButton(index == _boardingPages.length - 1
                          ? 'Get Started'
                          : 'Continue'),
                      // skip text
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: interFontFamily,
                            fontSize: 15,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

Widget _continueButton(String text) {
  return Container(
    width: 200,
    height: 50,
    decoration: BoxDecoration(
      color: ColorManager.blueColor,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: ColorManager.darkBlueColor,
          fontFamily: interFontFamily,
          fontSize: 20,
          height: 1.5,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    ),
  );
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    height: 8,
    width: 24,
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFFF8C89A) : Colors.white,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

class OnBoardingPage {
  final ImageProvider image;
  final String title;
  final String description;

  OnBoardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
