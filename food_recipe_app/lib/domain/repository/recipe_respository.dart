import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/create_recipe_object.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromLikes();
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromIds(
      List<String> ids);

  Future<Either<Failure, List<RecipeEntity>>> getSavedRecipesSearch(
      GetRecipesSearchRequestDto request);
  Future<Either<Failure, List<RecipeEntity>>> getLikedRecipesSearch(
      GetRecipesSearchRequestDto request);
  Future<Either<Failure, List<RecipeEntity>>> getRecipesSearch(
      RecipeSearchObject object);
  Future<Either<Failure, RecipeEntity>> createRecipe(
      CreateRecipeObject createRecipeObject);
  Future<Either<Failure, bool>> deleteRecipe(String recipeId);
  Future<Either<Failure, void>> updateSaveRecipe(String recipeId, bool option);
  Future<Either<Failure, void>> updateLikeRecipe(String recipeId, bool option);
  Future<Either<Failure, RecipeEntity>> updateRecipe(UpdateRecipeRequestDto request);
  Future<Either<Failure, List<RecipeEntity>>> getMyRecipes(
      RecipeSearchObject obj);
}

class GetRecipesSearchRequestDto {
  final String searchTerm;
  final List<String> categories;
  final int page;

  GetRecipesSearchRequestDto(
      {this.searchTerm = "", this.categories = const [], this.page = 0});
}

class UpdateRecipeRequestDto {
  String id;
  String title;
  String instruction;
  String description;
  String categories;
  int serves;
  int representIndex;
  List<String> keepUrls;
  List<MultipartFile>? files;
  int cookTime;
  List<String> ingredients;
  bool isPublished;
  bool isVegan;
  UpdateRecipeRequestDto(
      {required this.id,
        required this.title,
      required this.instruction,
      required this.description,
      required this.categories,
      required this.serves,
      required this.representIndex,
      required this.keepUrls,
      this.files,
      required this.cookTime,
      required this.ingredients,
      required this.isPublished,
      required this.isVegan});
}
