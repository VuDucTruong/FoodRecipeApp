import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/get_recipes_by_category_object.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetRecipesByCategoryUseCase
    extends BaseUseCase<GetRecipesByCategoryObject, List<RecipeEntity>> {
  final RecipeRepository _recipeRespository;

  GetRecipesByCategoryUseCase(this._recipeRespository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> execute(
      GetRecipesByCategoryObject input) async {
    // TODO: implement execute
    return await _recipeRespository.getRecipesSearch(GetRecipesSearchRequestDto(
        categories: input.categories, page: input.page));
  }
}
