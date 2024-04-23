import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/requests/create_recipe_request.dart';
import 'package:food_recipe_app/data/responses/list_response.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';

abstract class RecipeRemoteDataSource {
  Future<ListResponse<RecipeResponse>> getRecipesFromLikes();
  //Future<RecipeResponse> createRecipe(CreateRecipeRequest createRecipeRequest);
  Future<ListResponse<RecipeResponse>> getRecipesByCategory(
      String category, int page);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final Dio _dio;
  final recipeEndpoint = '${Constant.baseUrl}/Recipe';

  RecipeRemoteDataSourceImpl(this._dio);

  @override
  Future<ListResponse<RecipeResponse>> getRecipesFromLikes() async {
    Response response = await _dio.get('$recipeEndpoint/get-from-likes');
    List<RecipeResponse> data = [];
    for (Map<String, dynamic> item in response.data) {
      data.add(RecipeResponse.fromJson(item));
    }
    RecipeResponse r;

    return ListResponse(data, response.statusCode, response.statusMessage);
  }

  /*@override
  Future<RecipeResponse> createRecipe(
      CreateRecipeRequest createRecipeRequest) async {
    FormData formData = FormData.fromMap(createRecipeRequest.toJson());
    Response response = await _dio.post('$recipeEndpoint/get-from-likes' , data: formData);
    return RecipeResponse.fromJson(response.data);
  }*/

  @override
  Future<ListResponse<RecipeResponse>> getRecipesByCategory(
      String category, int page) async {
    // TODO: implement getRecipesByCategory
    Response response =
        await _dio.get('$recipeEndpoint/search-categories/$category/$page');

    List<RecipeResponse> recipeList = [];
    if (response.statusCode == 200) {
      for (Map<String, dynamic> item in response.data) {
        recipeList.add(RecipeResponse.fromJson(item));
      }
    }
    return ListResponse(
        recipeList, response.statusCode, response.statusMessage);
  }
}
