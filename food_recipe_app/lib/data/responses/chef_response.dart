import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/responses/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chef_response.g.dart';

@JsonSerializable()
class ChefResponse {
  final String id;
  final DateTime createdAt;
  final List<String> recipeIds;

  final UserProfileInfoResponse profileInfo;
  final int followingCount;
  final int followerCount;

  ChefResponse(this.id, this.createdAt, this.profileInfo, this.recipeIds,
      this.followingCount, this.followerCount);

  factory ChefResponse.fromJson(Map<String, dynamic> json) =>
      _$ChefResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChefResponseToJson(this);

  static ChefResponse fromJsonMap(dynamic json) {
    return ChefResponse.fromJson(json as Map<String, dynamic>);
  }

  static List<ChefResponse> fromJsonList(dynamic jsonList) {
    try {
      debugPrint("jsonList: $jsonList");
      if (jsonList != null) {
        if (jsonList is List) {
          return jsonList.map((e) => ChefResponse.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      debugPrint("error in list map: $e");
      return [];
    }
  }
}
