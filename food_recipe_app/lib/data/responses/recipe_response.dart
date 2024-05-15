import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'recipe_response.g.dart';

@JsonSerializable()
class RecipeResponse {
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

  RecipeResponse(
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
      this.isVegan); // from json
  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);

  static List<RecipeResponse> fromJsonList(dynamic list) {
    return (list as List).map((e) => RecipeResponse.fromJson(e)).toList();
  }
  static RecipeResponse fromJsonMap(dynamic map) {
    return RecipeResponse.fromJson(map as Map<String, dynamic>);
  }

  // to json
  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}
