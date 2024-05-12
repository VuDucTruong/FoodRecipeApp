import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/di.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:get_it/get_it.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  final InitialRoute initialRoute = GetIt.instance<InitialRoute>();
  await initialRoute.getInitialRoute();
  initDeviceInfo(Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android);
  runApp(const MyApp());
}
