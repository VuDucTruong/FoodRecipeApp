import 'dart:ffi';

import 'package:food_recipe_app/data/responses/special_datatypes/int_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_domain_response.g.dart';

@JsonSerializable(explicitToJson: true,)
class UserDomainResponse {
  final String id;
  final DateTime createdAt;
  final UserAuthenticationInfoResponse authenticationInfo;
  final UserProfileInfoResponse profileInfo;
  final List<String> recipeIds;
  final List<String> savedRecipeIds;
  final List<String> followingIds;
  final List<String> followerIds;

  final List<UserLoginTicketResponse> loginTickets;

  UserDomainResponse({
    required this.id,
    required this.createdAt,
    required this.authenticationInfo,
    required this.profileInfo,
    required this.recipeIds,
    required this.savedRecipeIds,
    required this.followingIds,
    required this.followerIds,
    required this.loginTickets,
  });

  factory UserDomainResponse.fromJson(Map<String,dynamic> json)
  => _$UserDomainResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserDomainResponseToJson(this);

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
  final Int8 hungryHeads;

  UserProfileInfoResponse({
    required this.fullName,
    required this.avatarUrl,
    required this.isVegan,
    required this.bio,
    required this.categories,
    required this.hungryHeads,
  });

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
  final String email;
  final String password;
  final String googleId;
  final String facebookId;

  UserAuthenticationInfoResponse({
    required this.email,
    required this.password,
    required this.googleId,
    required this.facebookId,
  });
  factory UserAuthenticationInfoResponse.fromJson(Map<String,dynamic> json)
  => _$UserAuthenticationInfoResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserAuthenticationInfoResponseToJson(this);
}

@JsonSerializable()
class UserLoginTicketResponse {
  final String deviceId;
  final String refreshToken;
  final String deviceInfo;
  final DateTime createTime;
  final DateTime expireTime;

  UserLoginTicketResponse({
    required this.deviceId,
    required this.refreshToken,
    required this.deviceInfo,
    required this.createTime,
    required this.expireTime,
  });
  factory UserLoginTicketResponse.fromJson(Map<String,dynamic> json)
  => _$UserLoginTicketResponseFromJson(json);
  Map<String,dynamic> toJson() => _$UserLoginTicketResponseToJson(this);
}