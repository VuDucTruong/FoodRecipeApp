import 'package:food_recipe_app/data/responses/chef_response.dart';
import 'package:food_recipe_app/data/responses/notification_response.dart';
import 'package:food_recipe_app/data/responses/user_response.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

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
        profileInfo.fullName,
        profileInfo.avatarUrl,
        profileInfo.isVegan,
        profileInfo.bio,
        profileInfo.categories,
        profileInfo.hungryHeads);
    return ChefEntity(
        id, createdAt, chefProfile, recipeIds, followingIds, followerIds);
  }
}

extension NotificationDomainResponseMapper on NotificationResponse {
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
        profileInfo.fullName,
        profileInfo.avatarUrl,
        profileInfo.isVegan,
        profileInfo.bio,
        profileInfo.categories,
        profileInfo.hungryHeads);

    var myAuthenticationInfo = AuthenticationInformation(
        authenticationInfo.loginId,
        authenticationInfo.email,
        authenticationInfo.password);

    var myLoginTickets = loginTickets
        .map((e) => LoginTicket(e.refreshToken ?? "", e.deviceId ?? "",
            e.deviceInfo ?? "", e.createTime, e.expireTime))
        .toList();
    return UserEntity(id, createdAt, myAuthenticationInfo, myProfile, recipeIds,
        savedRecipeIds, followingIds, followerIds, myLoginTickets);
  }
}
