import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/home/home_view.dart';
import 'package:food_recipe_app/presentation/login/login_view.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPassRoute = '/forgotPass';
  static const String onBoardingRoute = '/onBoarding';
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
          builder: (context) => const HomeView(),
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
