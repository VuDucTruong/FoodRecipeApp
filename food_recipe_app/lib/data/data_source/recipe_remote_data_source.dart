import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';

abstract class RemoteDataSource {
  Future<List<RecipeResponse>> getRecipesFromLikes();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio;
  final recipeEndpoint = '${Constant.baseUrl}/Recipe';

  RemoteDataSourceImpl(this._dio);

  @override
  Future<List<RecipeResponse>> getRecipesFromLikes() async {
    Response response = await _dio.get('${recipeEndpoint}/get-from-likes');
    List<RecipeResponse> recipeList = [];
    for (Map<String, dynamic> item in response.data) {
      print(item);
      recipeList.add(RecipeResponse.fromJson(item));
    }
    return recipeList;
  }
}
