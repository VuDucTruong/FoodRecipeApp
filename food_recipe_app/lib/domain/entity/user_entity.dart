import 'dart:convert';

import 'package:flutter/material.dart';

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
  List<String> categories;
  int hungryHeads;

  ProfileInformation(this.fullName, this.avatarUrl, this.isVegan, this.bio,
      this.categories, this.hungryHeads);

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'isVegan': isVegan,
      'bio': bio,
      'categories': categories,
      'hungryHeads': hungryHeads
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
