import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/extensions.dart';
import 'package:food_recipe_app/data/requests/login_request.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/login_responses/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse<LoginResponse>> login(String email, String password);
  Future<BaseResponse<LoginResponse>> loginWithLoginId(String loginId,String linkedAccountType);
  Future<BaseResponse<String>> refreshAccessToken();
  Future<BaseResponse<bool>> forgotPassword(String email);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio _dio;
  final loginEndpoint = Constant.baseUrl+Constant.loginEndpoint;
  final AppPreferences _appPreferences;

  LoginRemoteDataSourceImpl(this._dio, this._appPreferences);

  @override
  Future<BaseResponse<LoginResponse>> login(String email, String password) async {
    debugPrint('$loginEndpoint/login');
    LoginRequest request = LoginRequest(email: email, password: password);
    final response = await _dio.post('$loginEndpoint/login', data: request.toJson(),);

    BaseResponse<LoginResponse> baseResponse =
    BaseResponse.fromJson(response.toMap(), (value) => LoginResponse.fromJson(value));
    debugPrint('in loginRemoteDataSourceImpl'
        'logging part: ${baseResponse.statusMessage.toString()}');
    return baseResponse;
  }

  @override
  Future<BaseResponse<LoginResponse>> loginWithLoginId(String loginId,String linkedAccountType) async {
    LoginRequest request = LoginRequest(loginId: loginId, linkedAccountType: linkedAccountType);
    final response = await _dio.post('$loginEndpoint/auto-login',
        data: request.toJson()
    );
    BaseResponse<LoginResponse> baseResponse =
    BaseResponse.fromJson(response.toMap(), (value) => LoginResponse.fromJson(value));
    // LoginResponse response = LoginResponse.fromJson(response.data);
    return baseResponse;
  }

  @override
  Future<BaseResponse<String>> refreshAccessToken() async {
    String refreshToken = await _appPreferences.getUserRefreshToken();
    final response = await _dio.post('$loginEndpoint/auto-login',
        data: refreshToken,
      options: Options(contentType: Headers.textPlainContentType));
    BaseResponse<String> baseResponse = BaseResponse.fromJson(response.toMap(), (value) => value.toString());
    return baseResponse;
  }

  @override
  Future<BaseResponse<bool>> forgotPassword(String email) {
    throw UnimplementedError();
  }
}
