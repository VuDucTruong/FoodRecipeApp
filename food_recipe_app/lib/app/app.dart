import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/presentation/blocs/language/language_cubit.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/theme_management.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final InitialRoute initialRoute = GetIt.instance<InitialRoute>();
    debugPrint('initialRoute.initialRoute: ${initialRoute.initialRoute}');
    return BlocProvider(
      create: (context) => LanguageCubit(GetIt.instance<AppPreferences>()),
      child: BlocBuilder<LanguageCubit, Locale>(
        buildWhen: (previous, current) => current != previous,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: initialRoute.initialRoute,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: getAppTheme(),
          );
        },
      ),
    );
  }
}
