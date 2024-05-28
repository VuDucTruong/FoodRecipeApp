import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
const String PREFS_KEY_REFRESH =  "PREFS_KEY_REFRESH";
const String PREFS_KEY_BACKGROUND_USER = "PREFS_KEY_BACKGROUND_USER";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.English.getValue();
    }
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.Vietnamese.getValue()) {
      // save prefs with english lang
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.English.getValue());
    } else {
      // save prefs with arabic lang
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.Vietnamese.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.Vietnamese.getValue()) {
      // return arabic local
      return VN_LOCAL;
    } else {
      // return english local
      return ENGLISH_LOCAL;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> getOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setUserToken(String token) async {
    _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
  }
  Future<void> setUserRefreshToken(String token) async {
    _sharedPreferences.setString(PREFS_KEY_REFRESH, token);
  }

  Future<String> getUserToken() async {
    return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "";
  }

  Future<String> getUserRefreshToken() async {
    return _sharedPreferences.getString(PREFS_KEY_REFRESH)??"";
  }


  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
    _sharedPreferences.remove(PREFS_KEY_TOKEN);
    _sharedPreferences.remove(PREFS_KEY_REFRESH);
  }
}
