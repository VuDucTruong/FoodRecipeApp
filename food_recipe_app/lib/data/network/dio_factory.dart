import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/domain/usecase/refresh_access_token_usecase.dart';
import 'package:logger/logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  initializeInterceptor(
      dio, RefreshAccessTokenUseCase refreshAccessTokenUseCase) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        Logger().i(
            'Request: ${options.uri} - Data: ${options.data} - params: ${options.queryParameters}');
        String token = _appPreferences.getUserToken();
        options.headers[AUTHORIZATION] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('interceptor response has message');
        Logger().i('Response: ${response.statusCode} - Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('interceptor error has error');
        Logger().e('Error: ${e.message}');
        if (e.response?.statusCode == 401) {
          try {
            refreshAccessTokenUseCase.execute(null).then((value) {
              value.fold((l) {
                return handler.reject(e);
                //TODO: handle when refresh token failed, should logout user
              }, (r) {
                _appPreferences.setUserToken(r);
                return handler.resolve(dio.request(e.requestOptions.path,
                    options: e.requestOptions));
              });
            });
          } catch (ex) {
            Logger().e(
                'Request: ${e.requestOptions.uri} - Data: ${e.requestOptions.data}: refreshToken unauthorized');
            return handler.reject(e);
          }
        } else {
          Logger().e(
              'Request: ${e.requestOptions.uri} - Data: ${e.requestOptions.data} - ${e.response}: error not 401');
          return handler.next(e);
        }
      },
    ));
  }

  DioFactory(this._appPreferences);
  Duration timeOut = const Duration(seconds: 20);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    if (kReleaseMode) {
      print("release mode no logs");
    }
    return dio;
  }
}
