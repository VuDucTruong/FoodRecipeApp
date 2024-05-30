import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateSavedRecipeUseCase extends BaseUseCase<UpdateSavedRecipeObject , bool> {
  RecipeRepository recipeRepository;


  UpdateSavedRecipeUseCase(this.recipeRepository);

  @override
  Future<Either<Failure, bool>> execute(UpdateSavedRecipeObject input) {
    return recipeRepository.updateSaveRecipe(input.recipeId, input.option);
  }
}


class UpdateSavedRecipeObject {
  String recipeId;
  bool option;

  UpdateSavedRecipeObject(this.recipeId, this.option);
}