import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
const String PREFS_KEY_REFRESH = "PREFS_KEY_REFRESH";
const String PREFS_KEY_BACKGROUND_USER = "PREFS_KEY_BACKGROUND_USER";
const String PREFS_KEY_NOTIFICATION = "PREFS_KEY_NOTIFICATION";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.English.getValue();
    }
  }

  Future<void> setLocale() async {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.Vietnamese.getValue()) {
      // save prefs with english lang
      await _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.English.getValue());
    } else {
      // save prefs with vi lang
      await _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.Vietnamese.getValue());
    }
  }

  Locale getLocale() {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.Vietnamese.getValue()) {
      // return vi local
      return VN_LOCAL;
    } else {
      // return english local
      return ENGLISH_LOCAL;
    }
  }

  bool getIsNotification() {
    return _sharedPreferences.getBool(PREFS_KEY_NOTIFICATION) ?? false;
  }

  Future<void> setIsNotification(bool value) async {
    await _sharedPreferences.setBool(PREFS_KEY_NOTIFICATION, value);
  }

  Future<void> setOnBoardingScreenViewed() async {
    await _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  bool getOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setUserToken(String token) async {
    await _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
  }

  Future<void> setUserRefreshToken(String token) async {
    await _sharedPreferences.setString(PREFS_KEY_REFRESH, token);
  }

  String getUserToken() {
    return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "";
  }

  String getUserRefreshToken() {
    return _sharedPreferences.getString(PREFS_KEY_REFRESH) ?? "";
  }

  Future<void> setIsUserLoggedIn() async {
    await _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    await _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
    await _sharedPreferences.remove(PREFS_KEY_TOKEN);
    await _sharedPreferences.remove(PREFS_KEY_REFRESH);
  }
}
