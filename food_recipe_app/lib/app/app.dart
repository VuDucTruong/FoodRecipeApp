import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/theme_management.dart';

import 'di.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    InitialRoute initialRoute = InitialRoute(instance());
    initialRoute.setInitialRoute();
    ThemeData themeData = getAppTheme();
    initDeviceInfo(themeData.platform);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: initialRoute.initialRoute,
      theme: themeData,
    );
  }
}
