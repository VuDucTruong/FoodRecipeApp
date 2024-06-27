import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateUserRecipeUseCase
    extends BaseUseCase<UpdateRecipeRequestDto, void> {
  RecipeRepository recipeRepository;

  UpdateUserRecipeUseCase(this.recipeRepository);

  @override
  Future<Either<Failure, RecipeEntity>> execute(UpdateRecipeRequestDto input) {
    return recipeRepository.updateRecipe(input);
  }
}
