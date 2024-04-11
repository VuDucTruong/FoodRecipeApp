import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:logger/logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPreferences _appPreferences;

  DioFactory(this._appPreferences);
  Duration timeOut = const Duration(minutes: 1);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    String token = await _appPreferences.getUserToken();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: token,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
        connectTimeout: timeOut, receiveTimeout: timeOut, headers: headers);

    if (kReleaseMode) {
      print("release mode no logs");
    }
    return dio;
  }
}
