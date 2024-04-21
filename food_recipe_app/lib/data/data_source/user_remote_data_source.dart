
import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/extensions.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/domain_responses/user_domain_response.dart';

abstract class UserRemoteDataSource{
  Future<BaseResponse<UserDomainResponse>> getUserInfo();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  final Dio _dio;
  String userEndpoint = Constant.baseUrl + Constant.userEndpoint;
  final AppPreferences _appPreferences;

  UserRemoteDataSourceImpl(this._dio, this._appPreferences);

  @override
  Future<BaseResponse<UserDomainResponse>> getUserInfo() async {
    final response = await _dio.get(userEndpoint);
    BaseResponse<UserDomainResponse> baseResponse =
    BaseResponse.fromJson(response.toMap(), (value) => UserDomainResponse.fromJson(value));
    return baseResponse;
  }
}