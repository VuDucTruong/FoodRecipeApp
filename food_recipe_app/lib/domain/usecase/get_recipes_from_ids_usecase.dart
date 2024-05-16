import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetRecipesFromIdsUseCase
    extends BaseUseCase<List<String>, List<RecipeEntity>> {
  RecipeRepository recipeRepository;

  GetRecipesFromIdsUseCase(this.recipeRepository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> execute(
      List<String> input) async {
    return await recipeRepository.getRecipesFromIds(input);
  }
}
