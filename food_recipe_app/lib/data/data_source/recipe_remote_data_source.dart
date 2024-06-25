import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/requests/create_recipe_request.dart';
import 'package:food_recipe_app/data/requests/get_recipes_search_request.dart';
import 'package:food_recipe_app/data/requests/recipe_update_request.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';

import '../requests/get_my_recipes_request.dart';

abstract class RecipeRemoteDataSource {
  Future<BaseResponse<List<RecipeResponse>>> getRecipesFromLikes();
  Future<BaseResponse<List<RecipeResponse>>> getRecipesFromIds(
      List<String> ids);
  Future<BaseResponse<List<RecipeResponse>>> getRecipesByCategoriesSearch(
      GetRecipesSearchRequest request);
  Future<BaseResponse<List<RecipeResponse>>> getSavedRecipesSearch(
      GetRecipesSearchRequest request);
  Future<BaseResponse<List<RecipeResponse>>> getLikedRecipesSearch(
      GetRecipesSearchRequest request);

  Future<BaseResponse<List<RecipeResponse>>> getRecipesSearch(
      GetRecipesSearchRequest request);

  Future<BaseResponse<RecipeResponse>> createRecipe(
      CreateRecipeRequest createRecipeRequest);
  Future<BaseResponse<bool>> deleteRecipe(String recipeId);

  Future<BaseResponse<void>> updateSaveRecipe(String recipeId, bool option);
  Future<BaseResponse<void>> updateLikeRecipe(String recipeId, bool option);
  Future<BaseResponse<bool>> updateRecipe(RecipeUpdateRequest request);
  Future<BaseResponse<List<RecipeResponse>>> getMyRecipes(
      GetMyRecipesRequest request);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final Dio _dio;
  final recipeEndpoint = '${Constant.baseUrl}/Recipe';

  RecipeRemoteDataSourceImpl(this._dio);

  @override
  Future<BaseResponse<List<RecipeResponse>>> getRecipesFromLikes() async {
    Response response = await _dio.get('$recipeEndpoint/get-from-likes');
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<RecipeResponse>> createRecipe(
      CreateRecipeRequest createRecipeRequest) async {
    debugPrint("jaskldjfklasjdklfjaklsdjfkllasjkdfkjaodsfoaijdsfijawe");
    debugPrint(createRecipeRequest.toJson().toString());
    var jsonContent = createRecipeRequest.toJson();
    FormData formData = FormData.fromMap(jsonContent);
    debugPrint('formData: $formData');
    debugPrint('form data is null? ${formData == null}');
    Response response = await _dio.post('$recipeEndpoint/create',
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType));
    debugPrint('response: $response');
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonMap);
  }

  @override
  Future<BaseResponse<List<RecipeResponse>>> getRecipesByCategoriesSearch(
      GetRecipesSearchRequest request) async {
    Response response = await _dio.get('$recipeEndpoint/search',
        queryParameters: request.toJson());
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<List<RecipeResponse>>> getSavedRecipesSearch(
      GetRecipesSearchRequest getSavedRecipesRequest) async {
    Response response = await _dio.get('$recipeEndpoint/get-saved-recipes',
        queryParameters: getSavedRecipesRequest.toJson());
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<List<RecipeResponse>>> getRecipesFromIds(
      List<String> recipeIds) async {
    Response response = await _dio.get('$recipeEndpoint/get-from-ids',
        queryParameters: {'recipeIds': recipeIds});
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<List<RecipeResponse>>> getLikedRecipesSearch(
      GetRecipesSearchRequest request) async {
    Response response = await _dio.get('$recipeEndpoint/get-liked-recipes',
        queryParameters: request.toJson());
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<List<RecipeResponse>>> getRecipesSearch(
      GetRecipesSearchRequest request) async {
    Response response = await _dio.get('$recipeEndpoint/search',
        queryParameters: request.toJson());
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }

  @override
  Future<BaseResponse<void>> updateLikeRecipe(
      String recipeId, bool option) async {
    Response response = await _dio.put('$recipeEndpoint/like-recipe/$recipeId',
        queryParameters: {'option': option});
    return BaseResponse.fromJson(
      response,
      (p0) {},
    );
  }

  @override
  Future<BaseResponse<void>> updateSaveRecipe(
      String recipeId, bool option) async {
    Response response = await _dio.put('$recipeEndpoint/save-recipe/$recipeId',
        queryParameters: {'option': option});
    return BaseResponse.fromJson(
      response,
      (p0) {},
    );
  }

  @override
  Future<BaseResponse<bool>> updateRecipe(RecipeUpdateRequest request) async {
    Response response = await _dio.put('$recipeEndpoint/update',
        data: request.toJson(),
        options: Options(contentType: Headers.jsonContentType));
    return BaseResponse.fromJson(response, (data) => data as bool);
  }

  @override
  Future<BaseResponse<bool>> deleteRecipe(String recipeId) async {
    Response response = await _dio.delete('$recipeEndpoint/$recipeId');
    return BaseResponse.fromJson(response, (data) => data as bool);
  }

  @override
  Future<BaseResponse<List<RecipeResponse>>> getMyRecipes(
      GetMyRecipesRequest request) async {
    Response response = await _dio.get('$recipeEndpoint/get-owned-recipes',
        queryParameters: request.toJson());
    return BaseResponse.fromJson(response, RecipeResponse.fromJsonList);
  }
}
