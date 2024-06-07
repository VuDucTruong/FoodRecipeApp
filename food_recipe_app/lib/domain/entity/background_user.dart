import 'package:food_recipe_app/domain/entity/user_entity.dart';

class BackgroundUser {
  String id;
  DateTime createdAt;
  String email;
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
        required this.email,
      required this.profileInfo,
      required this.recipeIds,
      required this.likedRecipeIds,
      required this.savedRecipeIds,
      required this.followingIds,
      required this.followerIds,
      required this.loginTickets});

  @override
  String toString() {
    return 'BackgroundUser{id: $id, createdAt: $createdAt, email: $email, profileInfo: $profileInfo, recipeIds: $recipeIds, likedRecipeIds: $likedRecipeIds, savedRecipeIds: $savedRecipeIds, followingIds: $followingIds, followerIds: $followerIds, loginTickets: $loginTickets}';
  }

  BackgroundUser.fromUserEntity({
    required UserEntity userEntity,
  })  : id = userEntity.id,
        createdAt = userEntity.createdAt,
        email = userEntity.authenticationInfo.email!,
        profileInfo = userEntity.profileInfo,
        recipeIds = userEntity.recipeIds,
        likedRecipeIds = userEntity.likedRecipeIds,
        savedRecipeIds = userEntity.savedRecipeIds,
        followingIds = userEntity.followingIds,
        followerIds = userEntity.followerIds,
        loginTickets = userEntity.loginTickets;
}
