import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/chef_profile/chef_profile_view.dart';
import 'package:food_recipe_app/presentation/detail_food/detail_food_view.dart';
import 'package:food_recipe_app/presentation/edit_profile/edit_profile_view.dart';

import 'package:food_recipe_app/presentation/login/login_view.dart';
import 'package:food_recipe_app/presentation/main/main_view.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';

import '../main/home/home_page.dart';

class Routes {
  static const String splashRoute = '/';
  static const String mainRoute = '/main';
  static const String homeRoute = '/main/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPassRoute = '/forgotPass';
  static const String onBoardingRoute = '/onBoarding';
  static const String chefProfileRoute = '/chefProfile';
  static const String detailFoodRoute = '/detailFood';
  static const String editProfileRoute = '/editProfile';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case Routes.chefProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const ChefProfileView(),
        );
      case Routes.detailFoodRoute:
        return MaterialPageRoute(
          builder: (context) => const DetailFoodView(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainView(),
        );
      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const EditProfileView(),
        );
      default:
        return undefinedRoute();
    }
  }
}

Route<dynamic> undefinedRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      body: Center(child: Text(AppStrings.notFoundRoute)),
    ),
  );
}
