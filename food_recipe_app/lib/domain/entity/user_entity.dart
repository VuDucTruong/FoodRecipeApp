import 'dart:convert';

class UserEntity {
  String id;
  DateTime createdAt;
  AuthenticationInformation authenticationInfo;
  ProfileInformation profileInfo;
  List<String> recipeIds;
  List<String> likedRecipeIds;
  List<String> savedRecipeIds;
  List<String> followingIds;
  List<String> followerIds;
  List<LoginTicket> loginTickets;

  UserEntity(
      this.id,
      this.createdAt,
      this.authenticationInfo,
      this.profileInfo,
      this.recipeIds,
      this.likedRecipeIds,
      this.savedRecipeIds,
      this.followingIds,
      this.followerIds,
      this.loginTickets);

  String encodeUser() {
    return jsonEncode(this);
  }
}

class ProfileInformation {
  String fullName;
  String avatarUrl;
  bool isVegan;
  String bio;
  String? facebookLink;
  String? googleLink;
  List<String> categories;
  int hungryHeads;

  ProfileInformation(
      {required this.fullName,
      required this.avatarUrl,
      required this.isVegan,
      required this.bio,
      required this.categories,
      required this.hungryHeads,
      required this.facebookLink,
      required this.googleLink});
  ProfileInformation.defaultValues(
      {this.fullName = '',
      this.avatarUrl = '',
      this.isVegan = false,
      this.bio = '',
      this.categories = const [],
      this.hungryHeads = 0,
      this.facebookLink = '',
      this.googleLink = ''});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'isVegan': isVegan,
      'bio': bio,
      'categories': categories,
      'hungryHeads': hungryHeads,
      'facebookLink': facebookLink ?? '',
      'gmailLink': googleLink ?? ''
    };
  }
}

class AuthenticationInformation {
  String? loginId;
  String? email;
  String? password;

  AuthenticationInformation(this.loginId, this.email, this.password);
}

class LoginTicket {
  String refreshToken;
  String deviceId;
  String? deviceInfo;
  DateTime createTime;
  DateTime expireTime;

  LoginTicket(this.refreshToken, this.deviceInfo, this.deviceId,
      this.createTime, this.expireTime);

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'deviceId': deviceId,
      'deviceInfo': deviceInfo,
      'createTime': createTime.toIso8601String(),
      'expireTime': expireTime.toIso8601String()
    };
  }
}
