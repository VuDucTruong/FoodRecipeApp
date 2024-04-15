// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_domain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDomainResponse _$RecipeDomainResponseFromJson(
        Map<String, dynamic> json) =>
    RecipeDomainResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      instruction: json['instruction'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      representIndex:
          const Uint8Converter().fromJson(json['representIndex'] as String),
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      categories: json['categories'] as String,
      likes: const Uint32Converter().fromJson(json['likes'] as String),
      commentBatchIds: (json['commentBatchIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cookTime: const DurationConverter().fromJson(json['cookTime'] as int),
      ingredients: Map<String, String>.from(json['ingredients'] as Map),
      isPublished: json['isPublished'] as bool,
    );

Map<String, dynamic> _$RecipeDomainResponseToJson(
        RecipeDomainResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'instruction': instance.instruction,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'representIndex': const Uint8Converter().toJson(instance.representIndex),
      'attachmentUrls': instance.attachmentUrls,
      'categories': instance.categories,
      'likes': const Uint32Converter().toJson(instance.likes),
      'commentBatchIds': instance.commentBatchIds,
      'cookTime': const DurationConverter().toJson(instance.cookTime),
      'ingredients': instance.ingredients,
      'isPublished': instance.isPublished,
    };
