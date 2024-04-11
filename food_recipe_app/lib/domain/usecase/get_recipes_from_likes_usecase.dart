import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/respository/recipe_respository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetRecipesFromLikesUseCase implements BaseUseCase {
  final RecipeRespository _recipeRespository;

  GetRecipesFromLikesUseCase(this._recipeRespository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> execute(input) async {
    return await _recipeRespository.getRecipesFromLikes();
  }
}
