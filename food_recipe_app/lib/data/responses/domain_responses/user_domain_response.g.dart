// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_domain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDomainResponse _$UserDomainResponseFromJson(Map<String, dynamic> json) {
      debugPrint('in user domain response: ${json.toString()}');
      return
            UserDomainResponse(
                  id: json['id'] as String,
                  authenticationInfo: UserAuthenticationInfoResponse.fromJson(
                      json['authenticationInfo'] as Map<String, dynamic>),
                  createdAt: DateTime.parse(json['createdAt'] as String),
                  profileInfo: UserProfileInfoResponse.fromJson(
                      json['profileInfo'] as Map<String, dynamic>),
                  recipeIds:
                  (json['recipeIds'] as List<dynamic>).map((e) => e as String).toList(),
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
}

Map<String, dynamic> _$UserDomainResponseToJson(UserDomainResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'authenticationInfo': instance.authenticationInfo.toJson(),
      'profileInfo': instance.profileInfo.toJson(),
      'recipeIds': instance.recipeIds,
      'savedRecipeIds': instance.savedRecipeIds,
      'followingIds': instance.followingIds,
      'followerIds': instance.followerIds,
      'loginTickets': instance.loginTickets.map((e) => e.toJson()).toList(),
    };

UserProfileInfoResponse _$UserProfileInfoResponseFromJson(
        Map<String, dynamic> json) {
      debugPrint('in user profile info response: ${json.toString()}');
      try{
            return UserProfileInfoResponse(
                  fullName: json['fullName'] as String,
                  avatarUrl: json['avatarUrl'] as String,
                  isVegan: json['isVegan'] as bool,
                  bio: json['bio'] as String,
                  categories: (json['categories'] as List<dynamic>)
                      .map((e) => e as String)
                      .toList(),
                  hungryHeads:json['hungryHeads']
            );
      }
      catch(e) {
            debugPrint('error in user profile info response: ${e.toString()}');
            return UserProfileInfoResponse(fullName: '', avatarUrl: '',
                isVegan: false, bio: '', categories: [], hungryHeads: 0);
      }
}

Map<String, dynamic> _$UserProfileInfoResponseToJson(
        UserProfileInfoResponse instance) {
      try{
            return
                  <String, dynamic>{
                        'fullName': instance.fullName,
                        'avatarUrl': instance.avatarUrl,
                        'isVegan': instance.isVegan,
                        'bio': instance.bio,
                        'categories': instance.categories,
                        'hungryHeads': instance.hungryHeads,
                  };
      }
      catch(e) {
            debugPrint('error in user profile info response: ${e.toString()}');
            return <String, dynamic>{};
      }
}

UserAuthenticationInfoResponse _$UserAuthenticationInfoResponseFromJson(
        Map<String, dynamic> json) =>
    UserAuthenticationInfoResponse(
      email: json['email'] as String?,
      password: json['password'] as String?,
      googleId: json['googleId'] as String?,
      facebookId: json['facebookId'] as String?,
    );

Map<String, dynamic> _$UserAuthenticationInfoResponseToJson(
        UserAuthenticationInfoResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'googleId': instance.googleId,
      'facebookId': instance.facebookId,
    };

UserLoginTicketResponse _$UserLoginTicketResponseFromJson(
        Map<String, dynamic> json) =>
    UserLoginTicketResponse(
      deviceId: json['deviceId'] as String,
      refreshToken: json['refreshToken'] as String,
      deviceInfo: json['deviceInfo'] as String,
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
