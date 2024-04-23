import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetRecipesByCategoryUseCase
    extends BaseUseCase<GetRecipesByCategoryInput, List<RecipeEntity>> {
  final RecipeRepository _recipeRespository;

  GetRecipesByCategoryUseCase(this._recipeRespository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> execute(
      GetRecipesByCategoryInput input) async {
    // TODO: implement execute
    return await _recipeRespository.getRecipesByCategory(
        input.category, input.page);
  }
}

class GetRecipesByCategoryInput {
  String category;
  int page;

  GetRecipesByCategoryInput({required this.category, this.page = 0});
}
