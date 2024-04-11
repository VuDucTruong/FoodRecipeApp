// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeResponse _$RecipeResponseFromJson(Map<String, dynamic> json) =>
    RecipeResponse(
      json['id'] as String,
      json['userId'] as String,
      json['title'] as String,
      json['instruction'] as String,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      (json['attachmentUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['likes'] as int,
      (json['commentBatchIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['cookTime'] as int,
      Map<String, String>.from(json['ingredients'] as Map),
      json['isPublished'] as bool,
    );

Map<String, dynamic> _$RecipeResponseToJson(RecipeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'instruction': instance.instruction,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'attachmentUrls': instance.attachmentUrls,
      'likes': instance.likes,
      'commentBatchIds': instance.commentBatchIds,
      'cookTime': instance.cookTime,
      'ingredients': instance.ingredients,
      'isPublished': instance.isPublished,
    };
