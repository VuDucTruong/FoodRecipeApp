// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as String,
      authenticationInfo: UserAuthenticationInfoResponse.fromJson(
          json['authenticationInfo'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      profileInfo: UserProfileInfoResponse.fromJson(
          json['profileInfo'] as Map<String, dynamic>),
      recipeIds:
          (json['recipeIds'] as List<dynamic>).map((e) => e as String).toList(),
      likedRecipeIds: (json['likedRecipeIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      savedRecipeIds: (json['savedRecipeIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      followingIds: (json['followingIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      followerIds: (json['followerIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      loginTickets: (json['loginTickets'] as List<dynamic>)
          .map((e) =>
              UserLoginTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'authenticationInfo': instance.authenticationInfo.toJson(),
      'profileInfo': instance.profileInfo.toJson(),
      'recipeIds': instance.recipeIds,
      'likedRecipeIds': instance.likedRecipeIds,
      'savedRecipeIds': instance.savedRecipeIds,
      'followingIds': instance.followingIds,
      'followerIds': instance.followerIds,
      'loginTickets': instance.loginTickets.map((e) => e.toJson()).toList(),
    };

UserProfileInfoResponse _$UserProfileInfoResponseFromJson(
        Map<String, dynamic> json) =>
    UserProfileInfoResponse(
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String,
      isVegan: json['isVegan'] as bool,
      bio: json['bio'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hungryHeads: (json['hungryHeads'] as num).toInt(),
          facebookLink: json['facebookLink'] as String?,
          googleLink: json['googleLink'] as String?,
    );

Map<String, dynamic> _$UserProfileInfoResponseToJson(
        UserProfileInfoResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'isVegan': instance.isVegan,
      'bio': instance.bio,
      'categories': instance.categories,
      'hungryHeads': instance.hungryHeads,
      'facebookLink': instance.facebookLink,
      'googleLink': instance.googleLink,
    };

UserAuthenticationInfoResponse _$UserAuthenticationInfoResponseFromJson(
        Map<String, dynamic> json) =>
    UserAuthenticationInfoResponse(
      email: json['email'] as String?,
      password: json['password'] as String?,
      loginId: json['loginId'] as String?,
      linkedAccountType: json['linkedAccountType'] as String?,
    );

Map<String, dynamic> _$UserAuthenticationInfoResponseToJson(
        UserAuthenticationInfoResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'loginId': instance.loginId,
      'linkedAccountType': instance.linkedAccountType,
    };

UserLoginTicketResponse _$UserLoginTicketResponseFromJson(
        Map<String, dynamic> json) =>
    UserLoginTicketResponse(
      deviceId: json['deviceId'] as String?,
      refreshToken: json['refreshToken'] as String?,
      deviceInfo: json['deviceInfo'] as String?,
      createTime: DateTime.parse(json['createTime'] as String),
      expireTime: DateTime.parse(json['expireTime'] as String),
    );

Map<String, dynamic> _$UserLoginTicketResponseToJson(
        UserLoginTicketResponse instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'refreshToken': instance.refreshToken,
      'deviceInfo': instance.deviceInfo,
      'createTime': instance.createTime.toIso8601String(),
      'expireTime': instance.expireTime.toIso8601String(),
    };
