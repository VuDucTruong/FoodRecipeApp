import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/data/responses/special_datatypes/int_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable(explicitToJson: true,)
class UserResponse {
  final String id;
  final DateTime createdAt;
  final UserAuthenticationInfoResponse authenticationInfo;
  final UserProfileInfoResponse profileInfo;
  final List<String> recipeIds;
  final List<String> likedRecipeIds;
  final List<String> savedRecipeIds;
  final List<String> followingIds;
  final List<String> followerIds;

  final List<UserLoginTicketResponse> loginTickets;

  UserResponse({
    required this.id,
    required this.authenticationInfo,
    required this.createdAt,
    required this.profileInfo,
    required this.recipeIds,
    required this.likedRecipeIds,
    required this.savedRecipeIds,
    required this.followingIds,
    required this.followerIds,
    required this.loginTickets,
  });
  UserResponse.defaultValues({
    this.id = '',
    required this.authenticationInfo,
    required this.profileInfo,
    this.recipeIds = const [],
    this.likedRecipeIds= const[],
    this.savedRecipeIds = const [],
    this.followingIds = const [],
    this.followerIds = const [],
    this.loginTickets = const [],
  }):createdAt = DateTime.now();


  factory UserResponse.fromJson(Map<String,dynamic> json)
  => _$UserResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserResponseToJson(this);

  @override
  String toString() {
    return 'UserDomainResponse{id: $id, createdAt: $createdAt, authenticationInfo: $authenticationInfo, profileInfo: $profileInfo, recipeIds: $recipeIds, savedRecipeIds: $savedRecipeIds, followingIds: $followingIds, followerIds: $followerIds, loginTickets: $loginTickets}';
  }
}

@JsonSerializable()
class UserProfileInfoResponse {
  final String fullName;
  final String avatarUrl;
  final bool isVegan;
  final String bio;
  final List<String> categories;
  @Int8Converter()
  final int hungryHeads;

  UserProfileInfoResponse({
    required this.fullName,
    required this.avatarUrl,
    required this.isVegan,
    required this.bio,
    required this.categories,
    required this.hungryHeads,
  });

  UserProfileInfoResponse.defaultValues({
    this.fullName = '',
    this.avatarUrl = '',
    this.isVegan = false,
    this.bio = '',
    this.categories = const [],
  }): hungryHeads = 1;

  factory UserProfileInfoResponse.fromJson(Map<String,dynamic> json)
  => _$UserProfileInfoResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserProfileInfoResponseToJson(this);

  @override
  String toString() {
    return 'UserProfileInfoResponse{fullName: $fullName, avatarUrl: $avatarUrl, isVegan: $isVegan, bio: $bio, categories: $categories, hungryHeads: $hungryHeads}';
  }
}
@JsonSerializable()
class UserAuthenticationInfoResponse {
  final String? email;
  final String? password;
  final String? loginId;
  final String? linkedAccountType;

  UserAuthenticationInfoResponse({
    required this.email,
    required this.password,
    required this.loginId,
    required this.linkedAccountType,
  });
  UserAuthenticationInfoResponse.defaultValues({
    this.email = '',
    this.password = '',
    this.loginId = '',
    this.linkedAccountType = '',
  });
  factory UserAuthenticationInfoResponse.fromJson(Map<String,dynamic> json)
  => _$UserAuthenticationInfoResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserAuthenticationInfoResponseToJson(this);
}

@JsonSerializable()
class UserLoginTicketResponse {
  final String? deviceId;
  final String? refreshToken;
  final String? deviceInfo;
  final DateTime createTime;
  final DateTime expireTime;

  UserLoginTicketResponse({
    required this.deviceId,
    required this.refreshToken,
    required this.deviceInfo,
    required this.createTime,
    required this.expireTime,
  });

  UserLoginTicketResponse.defaultValues({
    this.deviceId = '',
    this.refreshToken = '',
    this.deviceInfo = '',
  }):createTime = DateTime.now(),
    expireTime = DateTime.now().add(const Duration(days: 7));

  factory UserLoginTicketResponse.fromJson(Map<String,dynamic> json)
  => _$UserLoginTicketResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserLoginTicketResponseToJson(this);
}