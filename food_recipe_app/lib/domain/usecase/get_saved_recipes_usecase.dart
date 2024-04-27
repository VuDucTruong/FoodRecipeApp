import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';
import 'package:food_recipe_app/presentation/common/helper/get_saved_recipes_object.dart';

class GetSavedRecipesUseCase
    extends BaseUseCase<GetSavedRecipesObject, List<RecipeEntity>> {
  final RecipeRepository _recipeRepository;

  GetSavedRecipesUseCase(this._recipeRepository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> execute(
      GetSavedRecipesObject input) async {
    return await _recipeRepository.getSavedRecipesByCategory(
        input.categories, input.searchTerm, input.page);
  }
}
