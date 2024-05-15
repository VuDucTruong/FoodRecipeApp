import 'package:food_recipe_app/domain/entity/user_entity.dart';

class ChefEntity {
  final String id;
  final DateTime createdAt;
  final ProfileInformation profileInfo;
  final List<String> recipeIds;
  final int followingCount;
  final int followerCount;

  ChefEntity(this.id, this.createdAt, this.profileInfo, this.recipeIds,
      this.followingCount, this.followerCount);
}
