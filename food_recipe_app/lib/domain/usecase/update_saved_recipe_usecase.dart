import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/object/status_recipe_object.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateSavedRecipeUseCase extends BaseUseCase<StatusRecipeObject, void> {
  RecipeRepository recipeRepository;

  UpdateSavedRecipeUseCase(this.recipeRepository);

  @override
  Future<Either<Failure, void>> execute(StatusRecipeObject input) {
    return recipeRepository.updateSaveRecipe(input.recipeId, input.option);
  }
}
