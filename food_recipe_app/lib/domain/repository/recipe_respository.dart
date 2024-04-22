import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';

abstract class RecipeRespository {
  Future<Either<Failure , List<RecipeEntity>>> getRecipesFromLikes();
  Future<Either<Failure , List<RecipeEntity>>> getRecipesByCategory(String category , int page);
}
