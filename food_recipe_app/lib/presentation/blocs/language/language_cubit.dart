import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/presentation/resources/language_manager.dart';
import 'package:meta/meta.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit(this.appPreferences) : super(const Locale('en'));
  AppPreferences appPreferences;
  Future<void> changeLanguage(BuildContext context) async {
    Locale newLocale = appPreferences.getLocale();
    if (newLocale == VN_LOCAL) {
      newLocale = ENGLISH_LOCAL;
    } else {
      newLocale = VN_LOCAL;
    }
    context.setLocale(newLocale);
    emit(newLocale);
    await appPreferences.setLocale();
  }
}
