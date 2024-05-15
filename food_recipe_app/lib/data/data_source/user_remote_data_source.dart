import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/extensions.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/chef_response.dart';
import 'package:food_recipe_app/data/responses/list_response.dart';
import 'package:food_recipe_app/data/responses/user_response.dart';

abstract class UserRemoteDataSource {
  Future<BaseResponse<UserResponse>> getUserInfo();
  Future<ListResponse<ChefResponse>> getVerifiedChefs();
  Future<BaseResponse<ChefResponse>> getChefInfo(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;
  String userEndpoint = Constant.baseUrl + Constant.userEndpoint;
  final AppPreferences _appPreferences;

  UserRemoteDataSourceImpl(this._dio, this._appPreferences);

  @override
  Future<BaseResponse<UserResponse>> getUserInfo() async {
    final response = await _dio.get(userEndpoint);
    BaseResponse<UserResponse> userResponse = BaseResponse.fromJson(
        response, (value) => UserResponse.fromJson(value));
    return userResponse;
  }

  @override
  Future<ListResponse<ChefResponse>> getVerifiedChefs() async {
    final response = await _dio.get('$userEndpoint/get-from-rank');
    List<ChefResponse> chefList = [];
    if (response.statusCode == 200) {
      for (Map<String, dynamic> item in response.data) {
        chefList.add(ChefResponse.fromJson(item));
      }
    }
    return ListResponse(chefList, response.statusCode, response.statusMessage);
  }

  @override
  Future<BaseResponse<ChefResponse>> getChefInfo(String id) async {
    final response = await _dio.get('$userEndpoint/$id');

    return BaseResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }
}
