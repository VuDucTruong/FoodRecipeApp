import 'package:dio/dio.dart';
import 'package:food_recipe_app/presentation/common/helper/create_recipe_object.dart';

class CreateRecipeRequest {
  String title;
  String instruction;
  String description;
  String categories;
  int serves;
  List<MultipartFile> files;
  int representIndex;
  int cookTime;
  List<String> ingredients;
  bool isPublished;
  bool isVegan;

  CreateRecipeRequest(
      this.title,
      this.instruction,
      this.description,
      this.categories,
      this.serves,
      this.files,
      this.representIndex,
      this.cookTime,
      this.ingredients,
      this.isPublished,
      this.isVegan); // to json
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "instruction": instruction,
      "description": description,
      "categories": categories,
      "serves": serves,
      "files": files, // Array of file objects or paths
      "representIndex": representIndex,
      "cookTime": cookTime,
      "ingredients": ingredients, // Array of ingredient strings
      "isPublished": isPublished,
      "isVegan": isVegan
    };
  }

  factory CreateRecipeRequest.fromObject(CreateRecipeObject object) {
    return CreateRecipeRequest(
        object.title,
        object.instruction,
        object.description,
        object.categories,
        object.serves,
        object.files,
        object.representIndex,
        object.cookTime,
        object.ingredients,
        object.isPublished,
        object.isVegan);
  }
}
