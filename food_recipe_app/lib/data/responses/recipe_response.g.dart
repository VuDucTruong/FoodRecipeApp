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
      json['description'] as String,
      json['instruction'] as String,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      json['representIndex'] as int,
      (json['attachmentUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['categories'] as String,
      json['likes'] as int,
      json['serves'] as int,
      json['cookTime'] as int,
      (json['ingredients'] as List<dynamic>).map((e) => e as String).toList(),
      json['isPublished'] as bool,
      json['isVegan'] as bool,
    );

Map<String, dynamic> _$RecipeResponseToJson(RecipeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'instruction': instance.instruction,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'representIndex': instance.representIndex,
      'attachmentUrls': instance.attachmentUrls,
      'categories': instance.categories,
      'likes': instance.likes,
      'serves': instance.serves,
      'cookTime': instance.cookTime,
      'ingredients': instance.ingredients,
      'isPublished': instance.isPublished,
      'isVegan': instance.isVegan,
    };
