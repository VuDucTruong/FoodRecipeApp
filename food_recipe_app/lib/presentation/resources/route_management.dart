import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/di.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:food_recipe_app/presentation/chef_profile/chef_profile_view.dart';
import 'package:food_recipe_app/presentation/detail_food/detail_food_view.dart';
import 'package:food_recipe_app/presentation/edit_profile/edit_profile_view.dart';
import 'package:food_recipe_app/presentation/main/main_view.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';

import 'package:food_recipe_app/presentation/login/login_view.dart';
import 'package:food_recipe_app/presentation/loadings/on_boarding_view.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/create_profile_view.dart';
import 'package:food_recipe_app/presentation/loadings/loading_page.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/setting_food_type_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String mainRoute = '/main';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  static const String forgotPassRoute = '/forgotPass';
  static const String onBoardingRoute = '/onBoarding';
  static const String chefProfileRoute = '/chefProfile';
  static const String detailFoodRoute = '/detailFood';
  static const String editProfileRoute = '/editProfile';
  static const String loadingRoute = '/loading';
  static const String settingKitchenRoute = '/settingKitchen';
  static const String createProfileRoute = '/createProfile';
  static const String foodTypeRoute = '/foodType';
}

class InitialRoute {
  String initialRoute = Routes.loginRoute;
  final AppPreferences _appPreferences;
  InitialRoute(this._appPreferences) {
    setInitialRoute();
  }
  void setInitialRoute() {
    _appPreferences.getUserRefreshToken().then((value) {
      if (value.isNotEmpty) {
        initialRoute = Routes.mainRoute;
      }
    }).catchError((e) {
      debugPrint('Error: $e');
    });
  }
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.loadingRoute:
        return MaterialPageRoute(
          builder: (context) => const LoadingScreen(),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
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
        initHomeModule();
        return MaterialPageRoute(
          builder: (context) => const MainView(),
        );
      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const EditProfileView(),
        );
      case Routes.createProfileRoute:
        initCreateProfileModule();
        if(routeSettings.arguments != null && routeSettings.arguments is ThirdPartySignInAccount){
          return MaterialPageRoute(
            builder: (context) => CreateProfileView(
              thirdPartySignInAccount: routeSettings.arguments as ThirdPartySignInAccount,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => CreateProfileView(),
        );
      case Routes.foodTypeRoute:
        initFoodTypeModule();
        if(routeSettings.arguments != null && routeSettings.arguments is UserRegisterProfileBasics){
          return MaterialPageRoute(
            builder: (context) => SettingFoodTypeView(
              userRegisterProfile: routeSettings.arguments as UserRegisterProfileBasics,
            ),
          );
        }
        return undefinedRoute();
      default:
        return undefinedRoute();
    }
  }
}

Route<dynamic> undefinedRoute() {
  return MaterialPageRoute(
    builder: (context) => const Scaffold(
      body: Center(child: Text(AppStrings.notFoundRoute)),
    ),
  );
}
