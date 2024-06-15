import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/theme_management.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final InitialRoute initialRoute = GetIt.instance<InitialRoute>();
    debugPrint('initialRoute.initialRoute: ${initialRoute.initialRoute}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: initialRoute.initialRoute,
      theme: getAppTheme(),
    );
  }
}
