import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/responses/chef_response.dart';
import 'package:food_recipe_app/data/responses/notification_response.dart';
import 'package:food_recipe_app/data/responses/user_response.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

import '../../domain/entity/background_user.dart';

extension RecipeResponseMapper on RecipeResponse {
  RecipeEntity toEntity() {
    return RecipeEntity(
        id,
        userId,
        title,
        description,
        instruction,
        createdAt,
        updatedAt,
        representIndex,
        attachmentUrls,
        categories,
        likes,
        serves,
        cookTime,
        ingredients,
        isPublished,
        isVegan);
  }
}

extension ChefResponseMapper on ChefResponse {
  ChefEntity toEntity() {
    var chefProfile = ProfileInformation(
        fullName: profileInfo.fullName,
        avatarUrl: profileInfo.avatarUrl,
        isVegan: profileInfo.isVegan,
        bio: profileInfo.bio,
        categories: profileInfo.categories,
        facebookLink: profileInfo.facebookLink,
        googleLink: profileInfo.googleLink,
        hungryHeads: profileInfo.hungryHeads);
    return ChefEntity(
        id, createdAt, chefProfile, recipeIds, followingCount, followerCount);
  }
}

extension AppNotificationResponseMapper on AppNotificationResponse {
  NotificationEntity toEntity() {
    return NotificationEntity(
        offSet: offSet,
        createdAt: createdAt,
        imageUrl: imageUrl ?? "",
        title: title,
        content: content,
        isRead: isRead,
        redirectPath: redirectPath ?? "");
  }
}

extension UserDomainResponseMapper on UserResponse {
  UserEntity toEntity() {
    var myProfile = ProfileInformation(
        fullName: profileInfo.fullName,
        avatarUrl: profileInfo.avatarUrl,
        isVegan: profileInfo.isVegan,
        bio: profileInfo.bio,
        categories: profileInfo.categories,
        facebookLink: profileInfo.facebookLink,
        googleLink: profileInfo.googleLink,
        hungryHeads: profileInfo.hungryHeads);

    var myAuthenticationInfo = AuthenticationInformation(
        authenticationInfo.loginId,
        authenticationInfo.email,
        authenticationInfo.password);

    var myLoginTickets = loginTickets
        .map((e) => LoginTicket(e.refreshToken ?? "", e.deviceId ?? "",
            e.deviceInfo ?? "", e.createTime, e.expireTime))
        .toList();
    return UserEntity(
        id,
        createdAt,
        myAuthenticationInfo,
        myProfile,
        recipeIds,
        likedRecipeIds,
        savedRecipeIds,
        followingIds,
        followerIds,
        myLoginTickets);
  }

  BackgroundUser toBackgroundUser() {
    try {
      var myProfile = ProfileInformation(
          fullName: profileInfo.fullName,
          avatarUrl: profileInfo.avatarUrl,
          isVegan: profileInfo.isVegan,
          bio: profileInfo.bio,
          categories: profileInfo.categories,
          facebookLink: profileInfo.facebookLink,
          googleLink: profileInfo.googleLink,
          hungryHeads: profileInfo.hungryHeads);

      var myLoginTickets = loginTickets
          .map((e) => LoginTicket(e.refreshToken ?? "", e.deviceId ?? "",
              e.deviceInfo ?? "", e.createTime, e.expireTime))
          .toList();
      return BackgroundUser(
          id: id,
          email: authenticationInfo.email!,
          createdAt: createdAt,
          profileInfo: myProfile,
          followerIds: followerIds,
          followingIds: followingIds,
          likedRecipeIds: likedRecipeIds,
          loginTickets: myLoginTickets,
          savedRecipeIds: savedRecipeIds,
          recipeIds: recipeIds);
    } catch (error) {
      debugPrint('mapper error: $error');
      return BackgroundUser(
          id: id,
          email: authenticationInfo.email!,
          createdAt: createdAt,
          profileInfo: ProfileInformation(
              fullName: "",
              avatarUrl: "",
              isVegan: false,
              facebookLink: null,
              googleLink: null,
              bio: "",
              categories: [],
              hungryHeads: 1),
          followerIds: [],
          followingIds: [],
          likedRecipeIds: [],
          loginTickets: [],
          savedRecipeIds: [],
          recipeIds: []);
    }
  }
}

extension UserProfileInfoResponseMapper on UserProfileInfoResponse {
  ProfileInformation toProfileInformation() {
    return ProfileInformation(
        fullName: fullName,
        avatarUrl: avatarUrl,
        isVegan: isVegan,
        bio: bio,
        categories: categories,
        facebookLink: facebookLink,
        googleLink: googleLink,
        hungryHeads: hungryHeads);
  }
}
