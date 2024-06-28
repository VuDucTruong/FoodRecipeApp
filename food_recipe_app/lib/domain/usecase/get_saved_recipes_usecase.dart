import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetSavedRecipesUseCase
    extends BaseUseCase<RecipeSearchObject, List<RecipeEntity>> {
  final RecipeRepository _recipeRepository;

  GetSavedRecipesUseCase(this._recipeRepository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> execute(
      RecipeSearchObject input) async {
    return await _recipeRepository.getSavedRecipesSearch(
        GetRecipesSearchRequestDto(
            categories: input.categories,
            page: input.page,
            searchTerm: input.searchTerm));
  }
}
