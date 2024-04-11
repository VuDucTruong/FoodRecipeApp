import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';

extension RecipeResponseMapper on RecipeResponse {
  RecipeEntity toDomain() {
    return RecipeEntity(id, userId, title, instruction, createdAt, updatedAt, attachmentUrls, likes, commentBatchIds, cookTime, ingredients, isPublished);
  }
}