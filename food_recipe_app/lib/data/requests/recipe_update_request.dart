import 'package:dio/dio.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';

class RecipeUpdateRequest {
  String id;
  String title;
  String instruction;
  String description;
  String categories;
  int serves;
  int representIndex;
  List<String> keepUrls;
  List<MultipartFile>? files;
  int cookTime;
  List<String> ingredients;
  bool isPublished;
  bool isVegan;
  RecipeUpdateRequest(
      {required this.id,
      required this.title,
      required this.instruction,
      required this.description,
      required this.categories,
      required this.serves,
      required this.representIndex,
      required this.keepUrls,
      required this.files,
      required this.cookTime,
      required this.ingredients,
      required this.isPublished,
      required this.isVegan});
  RecipeUpdateRequest.fromRecipeUpdateRequestDto(UpdateRecipeRequestDto request)
      : id = request.id,
        title = request.title,
        instruction = request.instruction,
        description = request.description,
        categories = request.categories,
        serves = request.serves,
        representIndex = request.representIndex,
        keepUrls = request.keepUrls,
        files = request.files,
        cookTime = request.cookTime,
        ingredients = request.ingredients,
        isPublished = request.isPublished,
        isVegan = request.isVegan;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "instruction": instruction,
      "description": description,
      "categories": categories,
      "serves": serves,
      "representIndex": representIndex,
      "keepUrls": keepUrls,
      "files": files, // Array of file objects or paths
      "cookTime": cookTime,
      "ingredients": ingredients, // Array of ingredient strings
      "isPublished": isPublished,
      "isVegan": isVegan
    };
  }
}
