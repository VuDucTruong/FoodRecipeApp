import 'package:json_annotation/json_annotation.dart';
part 'recipe_response.g.dart';

@JsonSerializable()
class RecipeResponse {
  String id;
  String userId;
  String title;
  String instruction;
  DateTime createdAt, updatedAt;
  List<String> attachmentUrls;
  int likes;
  List<String> commentBatchIds;
  int cookTime;
  Map<String, String> ingredients;
  bool isPublished;

  RecipeResponse(
      this.id,
      this.userId,
      this.title,
      this.instruction,
      this.createdAt,
      this.updatedAt,
      this.attachmentUrls,
      this.likes,
      this.commentBatchIds,
      this.cookTime,
      this.ingredients,
      this.isPublished);
  // from json
  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}
