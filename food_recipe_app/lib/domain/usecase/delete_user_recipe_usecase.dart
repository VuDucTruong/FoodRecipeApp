import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';

import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class DeleteUserRecipeUseCase extends BaseUseCase<String, bool> {
  RecipeRepository recipeRepository;

  DeleteUserRecipeUseCase(this.recipeRepository);

  @override
  Future<Either<Failure, bool>> execute(String input) {
    return recipeRepository.deleteRecipe(input);
  }
}
