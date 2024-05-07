import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/extensions.dart';
import 'package:food_recipe_app/data/requests/login_request.dart';
import 'package:food_recipe_app/data/requests/register_request.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/login_response.dart';
import 'package:food_recipe_app/data/responses/register_response.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse<LoginResponse>> login(LoginRequest request);
  Future<BaseResponse<LoginResponse>> loginWithLoginId(LoginRequest request);
  Future<BaseResponse<RegisterResponse>> registerWithEmail(RegisterWithEmailRequest request);
  Future<BaseResponse<RegisterResponse>> registerWithLoginId(RegisterWithLoginIdRequest request);
  Future<BaseResponse<String>> refreshAccessToken();
  Future<BaseResponse<bool>> forgotPassword(String email);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio _dio;
  final loginEndpoint = Constant.baseUrl + Constant.loginEndpoint;
  final AppPreferences _appPreferences;

  LoginRemoteDataSourceImpl(this._dio, this._appPreferences);

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    final response = await _dio.post(
      '$loginEndpoint/login-email',
      data: request.toJson(),
    );
    BaseResponse<LoginResponse> baseResponse = BaseResponse.fromJson(
        response, (value) => LoginResponse.fromJson(value));
    return baseResponse;
  }

  @override
  Future<BaseResponse<LoginResponse>> loginWithLoginId(
      LoginRequest request) async {
    final response =
        await _dio.post('$loginEndpoint/login-loginId', data: request.toJson());
    BaseResponse<LoginResponse> baseResponse = BaseResponse.fromJson(
        response, (value) => LoginResponse.fromJson(value));
    return baseResponse;
  }

  @override
  Future<BaseResponse<String>> refreshAccessToken() async {
    String refreshToken = await _appPreferences.getUserRefreshToken();
    final response = await _dio.post('$loginEndpoint/auto-login',
        data: refreshToken,
        options: Options(contentType: Headers.textPlainContentType));
    BaseResponse<String> baseResponse =
        BaseResponse.fromJson(response, (value) => value.toString());
    return baseResponse;
  }

  @override
  Future<BaseResponse<bool>> forgotPassword(String email) async {
    final response = await _dio.post('$loginEndpoint/forgot-password',
        data: email,
        options: Options(contentType: Headers.textPlainContentType));
    BaseResponse<bool> baseResponse =
        BaseResponse.fromJson(response, (value) => value as bool);
    return baseResponse;
  }

  @override
  Future<BaseResponse<RegisterResponse>> registerWithEmail(
      RegisterWithEmailRequest request) async {
    debugPrint("${request.toJson()}");
    final response = await _dio.post(
      '$loginEndpoint/register-email',
      data: FormData.fromMap(request.toJson()),
    );
    BaseResponse<RegisterResponse> baseResponse = BaseResponse.fromJson(
        response, (value) => RegisterResponse.fromJson(value));
    debugPrint('in loginRemoteDataSourceImpl'
        'register part: ${baseResponse.statusMessage.toString()}');
    return baseResponse;
  }

  @override
  Future<BaseResponse<RegisterResponse>> registerWithLoginId(RegisterWithLoginIdRequest request) async {    debugPrint('$loginEndpoint/register');
  debugPrint("${request.toJson()}");
  final response = await _dio.post(
    '$loginEndpoint/register-loginId',
    data: FormData.fromMap(request.toJson()),
    options: Options(contentType: Headers.multipartFormDataContentType),
  );
  BaseResponse<RegisterResponse> baseResponse = BaseResponse.fromJson(
      response, (value) => RegisterResponse.fromJson(value));
  return baseResponse;
  }
}
