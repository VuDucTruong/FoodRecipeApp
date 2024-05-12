// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chef_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChefResponse _$ChefResponseFromJson(Map<String, dynamic> json) => ChefResponse(
      json['id'] as String,
      DateTime.parse(json['createdAt'] as String),
      UserProfileInfoResponse.fromJson(
          json['profileInfo'] as Map<String, dynamic>),
      (json['recipeIds'] as List<dynamic>).map((e) => e as String).toList(),
    (json['followingCount'] as num).toInt(),
    (json['followerCount'] as num).toInt(),
    );

Map<String, dynamic> _$ChefResponseToJson(ChefResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'profileInfo': instance.profileInfo,
      'recipeIds': instance.recipeIds,

    };
