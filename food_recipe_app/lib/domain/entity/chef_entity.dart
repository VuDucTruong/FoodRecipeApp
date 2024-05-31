import 'package:food_recipe_app/domain/entity/user_entity.dart';

class ChefEntity {
  String id;
  DateTime createdAt;
  ProfileInformation profileInfo;
  List<String> recipeIds;
  int followingCount;
  int followerCount;

  ChefEntity(this.id, this.createdAt, this.profileInfo, this.recipeIds,
      this.followingCount, this.followerCount);
}
