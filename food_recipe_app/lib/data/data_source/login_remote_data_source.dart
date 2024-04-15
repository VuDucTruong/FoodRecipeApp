import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/requests/login_request.dart';
import 'package:food_recipe_app/data/responses/login_responses/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(String email, String password);
  Future<LoginResponse> loginWithGoogle(String googleId);
  Future<LoginResponse> loginWithFacebook(String facebookId);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio _dio;
  final loginEndpoint = '${Constant.baseUrl}/${Constant.loginEndpoint}';

  LoginRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponse> login(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);
    Response response = await _dio.post(loginEndpoint, data: request.toJson());
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    return loginResponse;
  }

  @override
  Future<LoginResponse> loginWithFacebook(String googleId) async {
    LoginRequest request = LoginRequest(googleId: googleId);
    Response response = await _dio.post(loginEndpoint, data: request.toJson());
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    return loginResponse;

  }

  @override
  Future<LoginResponse> loginWithGoogle(String facebookId) async {
    LoginRequest request = LoginRequest(facebookId: facebookId);
    Response response = await _dio.post(loginEndpoint, data: request.toJson());
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    return loginResponse;
  }
}
