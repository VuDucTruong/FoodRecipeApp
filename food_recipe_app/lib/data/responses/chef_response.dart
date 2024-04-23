import 'package:food_recipe_app/data/responses/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chef_response.g.dart';

@JsonSerializable()
class ChefResponse {
  final String id;
  final DateTime createdAt;
  final UserProfileInfoResponse profileInfo;
  final List<String> recipeIds;
  final List<String> followingIds;
  final List<String> followerIds;

  ChefResponse(this.id, this.createdAt, this.profileInfo, this.recipeIds,
      this.followingIds, this.followerIds);

  factory ChefResponse.fromJson(Map<String, dynamic> json) =>
      _$ChefResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChefResponseToJson(this);
}
