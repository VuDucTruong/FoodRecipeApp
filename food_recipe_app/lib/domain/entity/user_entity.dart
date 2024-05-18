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

class BackgroundUser {
  String id;
  DateTime createdAt;
  ProfileInformation profileInfo;
  List<String> recipeIds;
  List<String> likedRecipeIds;
  List<String> savedRecipeIds;
  List<String> followingIds;
  List<String> followerIds;
  List<LoginTicket> loginTickets;

  BackgroundUser(
      {required this.id,
      required this.createdAt,
      required this.profileInfo,
      required this.recipeIds,
      required this.likedRecipeIds,
      required this.savedRecipeIds,
      required this.followingIds,
      required this.followerIds,
      required this.loginTickets});

  BackgroundUser.fromUserEntity({
    required UserEntity userEntity,
  })  : id = userEntity.id,
        createdAt = userEntity.createdAt,
        profileInfo = userEntity.profileInfo,
        recipeIds = userEntity.recipeIds,
        likedRecipeIds = userEntity.likedRecipeIds,
        savedRecipeIds = userEntity.savedRecipeIds,
        followingIds = userEntity.followingIds,
        followerIds = userEntity.followerIds,
        loginTickets = userEntity.loginTickets;

  factory BackgroundUser.fromJson(Map<String, dynamic> json) {
    List<LoginTicket> loginTickets = [];
    for (var ticket in json['loginTickets']) {
      loginTickets.add(LoginTicket(
          ticket['refreshToken'],
          ticket['deviceId'],
          ticket['deviceInfo'],
          DateTime.parse(ticket['createTime']),
          DateTime.parse(ticket['expireTime'])));
    }
    return BackgroundUser(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        profileInfo: ProfileInformation(
            json['profileInfo']['fullName'],
            json['profileInfo']['avatarUrl'],
            json['profileInfo']['isVegan'],
            json['profileInfo']['bio'],
            json['profileInfo']['categories'],
            json['profileInfo']['hungryHeads']),
        likedRecipeIds: json['likedRecipeIds'].cast<String>(),
        recipeIds: json['recipeIds'].cast<String>(),
        savedRecipeIds: json['savedRecipeIds'].cast<String>(),
        followingIds: json['followingIds'].cast<String>(),
        followerIds: json['followerIds'].cast<String>(),
        loginTickets: loginTickets);
  }
  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'profileInfo': profileInfo.toJson(),
      'recipeIds': recipeIds,
      'likedRecipeIds': likedRecipeIds,
      'savedRecipeIds': savedRecipeIds,
      'followingIds': followingIds,
      'followerIds': followerIds,
      'loginTickets': loginTickets.map((e) => e.toJson()).toList()
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static BackgroundUser decode(String jsonstr) {
    return BackgroundUser.fromJson(jsonDecode(jsonstr));
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

  Map<String,dynamic> toJson(){
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

  Map<String,dynamic> toJson(){
    return {
      'refreshToken': refreshToken,
      'deviceId': deviceId,
      'deviceInfo': deviceInfo,
      'createTime': createTime.toIso8601String(),
      'expireTime': expireTime.toIso8601String()
    };
  }
}
