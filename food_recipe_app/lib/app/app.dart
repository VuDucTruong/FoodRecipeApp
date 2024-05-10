import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/theme_management.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key}) ;
  @override
  Widget build(BuildContext context) {
    final InitialRoute initialRoute = GetIt.instance<InitialRoute>();
    return FutureBuilder<String>(
      future: initialRoute.getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the result, you can show a loading indicator
          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/loading_screen.png', // Replace with the path to your local image
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // If there's an error, handle it appropriately
          return Text('Error: ${snapshot.error}');
        } else {
          // Once the result is available, create MaterialApp with the initial route
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: snapshot.data,
            theme: getAppTheme(),
          );
        }
      },
    );
  }
}

