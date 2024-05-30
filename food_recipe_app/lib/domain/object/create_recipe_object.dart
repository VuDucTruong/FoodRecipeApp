import 'dart:io';

import 'package:dio/dio.dart';

class CreateRecipeObject {
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

  CreateRecipeObject(
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
      this.isVegan);
}