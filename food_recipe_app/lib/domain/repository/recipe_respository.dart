import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/common/helper/create_recipe_object.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromLikes();
  Future<Either<Failure, List<RecipeEntity>>> getRecipesByCategory(
      String category, int page);
  Future<Either<Failure , RecipeEntity>> createRecipe(CreateRecipeObject createRecipeObject);
}
