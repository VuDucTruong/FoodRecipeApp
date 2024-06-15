import 'dart:convert';

import 'package:food_recipe_app/app/functions.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RecipeEntity {
  String id;
  String userId;
  String title;
  String description;
  String instruction;
  DateTime createdAt;
  DateTime updatedAt;
  int representIndex;
  List<String> attachmentUrls;
  String categories;
  int likes;
  int serves;
  int cookTime;
  List<String> ingredients;
  bool isPublished;
  bool isVegan;

  RecipeEntity(
      this.id,
      this.userId,
      this.title,
      this.description,
      this.instruction,
      this.createdAt,
      this.updatedAt,
      this.representIndex,
      this.attachmentUrls,
      this.categories,
      this.likes,
      this.serves,
      this.cookTime,
      this.ingredients,
      this.isPublished,
      this.isVegan);

  // Convert a RecipeEntity into a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'instruction': instruction,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'representIndex': representIndex,
      'attachmentUrls': attachmentUrls,
      'categories': categories,
      'likes': likes,
      'serves': serves,
      'cookTime': cookTime,
      'ingredients': ingredients,
      'isPublished': isPublished,
      'isVegan': isVegan,
    };
  }

  // Create a RecipeEntity from a Map
  factory RecipeEntity.fromJson(Map<String, dynamic> json) {
    return RecipeEntity(
      json['id'],
      json['userId'],
      json['title'],
      json['description'],
      json['instruction'],
      DateTime.parse(json['createdAt']),
      DateTime.parse(json['updatedAt']),
      json['representIndex'],
      List<String>.from(json['attachmentUrls']),
      json['categories'],
      json['likes'],
      json['serves'],
      json['cookTime'],
      List<String>.from(json['ingredients']),
      json['isPublished'],
      json['isVegan'],
    );
  }

  factory RecipeEntity.fromGeneratedContent(GenerateContentResponse content) {
    assert(content.text != null);
    final validJson = cleanJson(content.text!);
    final json = jsonDecode(validJson) as Map<String, dynamic>;

    if (json
        case {
          "ingredients": List<dynamic> ingredients,
          "instruction": String instruction,
          "title": String title,
          "categories": String categories,
          "description": String description,
          "servings": int servings,
          "cookTime": int cookTime,
          "isVegan": bool isVegan
        }) {
      return RecipeEntity(
          '',
          '',
          title,
          description,
          instruction,
          DateTime.now(),
          DateTime.now(),
          -1,
          [],
          categories,
          0,
          servings,
          cookTime,
          ingredients
              .map(
                (e) => e.toString(),
              )
              .toList(),
          false,
          isVegan);
    } else {
      throw ("Json format is wrong !");
    }
  }
  @override
  String toString() {
    return 'RecipeEntity{id: $title}';
  }
}
