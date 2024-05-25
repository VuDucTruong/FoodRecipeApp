import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/requests/user_search_request.dart';
import 'package:food_recipe_app/data/requests/user_update_request.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/chef_response.dart';
import 'package:food_recipe_app/data/responses/user_response.dart';

abstract class UserRemoteDataSource {
  Future<BaseResponse<ChefResponse>> getChefInfo(String id);
  Future<BaseResponse<List<ChefResponse>>> getVerifiedChefs();
  Future<BaseResponse<UserResponse>> getSelfInfo();
  Future<BaseResponse<ChefResponse>> getProfileById(String id);
  Future<BaseResponse<List<ChefResponse>>> getProfileSearch(
      UserSearchRequest request);
  Future<BaseResponse<UserProfileInfoResponse>> updateProfile(
      UserUpdateRequest request);
  Future<BaseResponse<bool>> deleteProfile();
  Future<BaseResponse<bool>> updatePassword(String password);
  Future<BaseResponse<bool>> updateFollow(String targetChefId, bool option);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;
  String userEndpoint = Constant.baseUrl + Constant.userEndpoint;
  final AppPreferences _appPreferences;

  UserRemoteDataSourceImpl(this._dio, this._appPreferences);

  @override
  Future<BaseResponse<List<ChefResponse>>> getVerifiedChefs() async {
    final response = await _dio.get('$userEndpoint/get-from-rank');
    return BaseResponse.fromJson(response, ChefResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<UserResponse>> getSelfInfo() async {
    final response = await _dio.get(userEndpoint);
    BaseResponse<UserResponse> userResponse = BaseResponse.fromJson(
        response, (value) => UserResponse.fromJson(value));
    return userResponse;
  }

  @override
  Future<BaseResponse<bool>> deleteProfile() async {
    final response = await _dio.delete(userEndpoint);
    return BaseResponse.fromJson(response, (data) => data);
  }

  @override
  Future<BaseResponse<ChefResponse>> getChefInfo(String id) async {
    final response = await _dio.get('$userEndpoint/$id');
    return BaseResponse.fromJson(response, ChefResponse.fromJsonMap);
  }

  @override
  Future<BaseResponse<ChefResponse>> getProfileById(String id) async {
    final response = await _dio.get('$userEndpoint/$id');
    return BaseResponse.fromJson(response, ChefResponse.fromJsonMap);
  }

  @override
  Future<BaseResponse<List<ChefResponse>>> getProfileSearch(
      UserSearchRequest request) async {
    final response = await _dio.get('$userEndpoint/search',
        queryParameters: request.toJson());
    return BaseResponse.fromJson(response, ChefResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<bool>> updateFollow(
      String targetChefId, bool option) async {
    final response = await _dio.put('$userEndpoint/follow/$targetChefId',
        queryParameters: {'option': option});
    return BaseResponse.fromJson(response, (data) => data);
  }

  @override
  Future<BaseResponse<bool>> updatePassword(String password) async {
    final response =
        await _dio.put('$userEndpoint/update-password',
            data: password,
          options: Options(contentType: Headers.textPlainContentType)
        );
    return BaseResponse<bool>.fromJson(response, (data) => data as bool);
  }

  @override
  Future<BaseResponse<UserProfileInfoResponse>> updateProfile(
      UserUpdateRequest request) async {
    final response = await _dio.put('$userEndpoint/update-profile',
        data: FormData.fromMap(request.toJson()),
        options: Options(contentType: Headers.multipartFormDataContentType));
    return BaseResponse<UserProfileInfoResponse>.fromJson(
        response, (value) => UserProfileInfoResponse.fromJson(value));
  }
}
