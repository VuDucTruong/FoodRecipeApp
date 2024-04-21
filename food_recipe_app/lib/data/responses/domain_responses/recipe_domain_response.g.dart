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
      description: json['description'] as String,
      instruction: json['instruction'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      representIndex: json['representIndex'] as int,
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      categories: json['categories'] as String,
      likes: json['likes'] as int,
      serves: json['serves'] as int,
      cookTime: const DurationConverter().fromJson(json['cookTime'] as int),
      ingredients: Map<String, String>.from(json['ingredients'] as Map),
      isPublished: json['isPublished'] as bool,
      isVegan: json['isVegan'] as bool,
    );

Map<String, dynamic> _$RecipeDomainResponseToJson(
        RecipeDomainResponse instance) =>
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
      'cookTime': const DurationConverter().toJson(instance.cookTime),
      'ingredients': instance.ingredients,
      'isPublished': instance.isPublished,
      'isVegan': instance.isVegan,
    };
