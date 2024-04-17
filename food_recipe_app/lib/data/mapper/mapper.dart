import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';

extension RecipeResponseMapper on RecipeResponse {
  RecipeEntity toDomain() {
    return RecipeEntity(
        id,
        userId,
        title,
        description,
        instruction,
        createdAt,
        updatedAt,
        representIndex,
        attachmentUrls,
        categories,
        likes,
        serves,
        cookTime,
        ingredients,
        isPublished,
        isVegan);
  }
}
