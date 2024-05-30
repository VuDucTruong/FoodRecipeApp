import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/object/status_recipe_object.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateLikeRecipeUseCase extends BaseUseCase<StatusRecipeObject, bool> {
  RecipeRepository recipeRepository;

  UpdateLikeRecipeUseCase(this.recipeRepository);

  @override
  Future<Either<Failure, bool>> execute(StatusRecipeObject input) {
    return recipeRepository.updateLikeRecipe(input.recipeId, input.option);
  }
}
