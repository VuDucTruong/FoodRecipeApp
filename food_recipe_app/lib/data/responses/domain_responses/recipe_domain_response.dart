import 'dart:ffi';

import 'package:food_recipe_app/data/responses/special_datatypes/duration_converter.dart';
import 'package:food_recipe_app/data/responses/special_datatypes/uint_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_domain_response.g.dart';

@JsonSerializable()
class RecipeDomainResponse {
  final String id;
  final String userId;
  final String title;
  final String instruction;
  final DateTime createdAt;
  final DateTime updatedAt;
  @Uint8Converter()
  final Uint8 representIndex;
  final List<String> attachmentUrls;
  final String categories;
  @Uint32Converter()
  final Uint32 likes;
  final List<String> commentBatchIds;
  @DurationConverter()
  final Duration cookTime;
  final Map<String, String> ingredients;
  final bool isPublished;

  RecipeDomainResponse({
    required this.id,
    required this.userId,
    required this.title,
    required this.instruction,
    required this.createdAt,
    required this.updatedAt,
    required this.representIndex,
    required this.attachmentUrls,
    required this.categories,
    required this.likes,
    required this.commentBatchIds,
    required this.cookTime,
    required this.ingredients,
    required this.isPublished,
  });

  factory RecipeDomainResponse.fromJson(Map<String,dynamic> json)
  => _$RecipeDomainResponseFromJson(json);
  Map<String,dynamic> toJson() => _$RecipeDomainResponseToJson(this);

}



