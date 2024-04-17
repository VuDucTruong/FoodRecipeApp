import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/respository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetRecipesByCategory
    extends BaseUseCase<GetRecipesByCategoryInput, List<RecipeEntity>> {
  final RecipeRespository _recipeRespository;

  GetRecipesByCategory(this._recipeRespository);

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
