import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

class CreateRecipeRequest {
  String title;
  String instruction;
  List<MultipartFile> files;
  int cookTime;
  Map<String, String> ingredients;
  bool isPublished;

  CreateRecipeRequest(this.title, this.instruction, this.files, this.cookTime,
      this.ingredients, this.isPublished);

  // to json
  Map<String, dynamic> toJson() => {
    "title": title,
    "instruction": instruction,
    "files": files,
    "cookTime": cookTime,
    "ingredients": ingredients,
    "isPublished": isPublished
  };
}
