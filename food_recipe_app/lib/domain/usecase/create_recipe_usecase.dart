import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';
import 'package:food_recipe_app/domain/object/create_recipe_object.dart';

class CreateRecipeUseCase
    extends BaseUseCase<CreateRecipeObject, RecipeEntity> {
  final RecipeRepository _recipeRepository;

  CreateRecipeUseCase(this._recipeRepository);

  @override
  Future<Either<Failure, RecipeEntity>> execute(
      CreateRecipeObject input) async {
    return await _recipeRepository.createRecipe(input);
  }
}
