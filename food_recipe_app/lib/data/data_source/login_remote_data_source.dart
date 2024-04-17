import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/extensions.dart';
import 'package:food_recipe_app/data/requests/login_request.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/login_responses/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse<LoginResponse>> login(String email, String password);
  Future<Response<LoginResponse>> loginWithGoogle(String googleId);
  Future<Response<LoginResponse>> loginWithFacebook(String facebookId);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio _dio;
  final loginEndpoint = Constant.baseUrl+Constant.loginEndpoint;

  LoginRemoteDataSourceImpl(this._dio);

  @override
  Future<BaseResponse<LoginResponse>> login(String email, String password) async {
    debugPrint('$loginEndpoint/login');
    LoginRequest request = LoginRequest(email: email, password: password);
    final response =
    await _dio.post('$loginEndpoint/login', data: {
      'email': email,
      'password': password
    },);
    debugPrint('run');

    // debugPrint(response.data.toString());
    BaseResponse<LoginResponse> baseResponse =
    BaseResponse.fromJson(response.toMap(), (value) {
      // debugPrint(value.toString());
      return  LoginResponse.fromJson(value);
    });
    debugPrint('in loginRemoteDataSourceImpl'
        'logging part: ${baseResponse.statusMessage.toString()}');
    return baseResponse;
  }

  @override
  Future<Response<LoginResponse>> loginWithFacebook(String googleId) async {
    LoginRequest request = LoginRequest(googleId: googleId);
    Response<LoginResponse> response = await _dio.post(loginEndpoint, data: request.toJson());
    // LoginResponse loginResponse = LoginResponse.fromJson(response.toMap());
    return response;

  }

  @override
  Future<Response<LoginResponse>> loginWithGoogle(String facebookId) async {
    LoginRequest request = LoginRequest(facebookId: facebookId);
    Response<LoginResponse> response = await _dio.post(loginEndpoint, data: request.toJson());
    // LoginResponse response = LoginResponse.fromJson(response.data);
    return response;
  }
}
