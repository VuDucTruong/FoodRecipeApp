import 'package:food_recipe_app/domain/entity/user_entity.dart';

class ChefEntity {
  final String id;
  final DateTime createdAt;
  final ProfileInformation profileInfo;
  final List<String> recipeIds;
  final List<String> followingIds;
  final List<String> followerIds;

  ChefEntity(this.id, this.createdAt, this.profileInfo, this.recipeIds,
      this.followingIds, this.followerIds);
}
