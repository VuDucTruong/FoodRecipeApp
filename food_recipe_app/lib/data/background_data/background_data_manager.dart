import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entity/background_user.dart';

class BackgroundDataManager {
  late BackgroundUser currentUser;

  ChefEntity convertToChefEntity() {
    return ChefEntity(
        currentUser.id,
        currentUser.createdAt,
        currentUser.profileInfo,
        currentUser.recipeIds,
        currentUser.followingIds.length,
        currentUser.followerIds.length);
  }

  void setBackgroundUser(BackgroundUser user) {
    currentUser = user;
  }

  BackgroundUser getBackgroundUser() {
    return currentUser;
  }

  void updateFollow(String chefId, bool option) {
    if (option) {
      currentUser.followerIds.add(chefId);
    } else {
      currentUser.followerIds.remove(chefId);
    }
  }

  void updateProfile(ProfileInformation profileInformation) {
    currentUser.profileInfo = profileInformation;
  }

  void updateLikeRecipe(String recipeId, bool option) {
    if (option) {
      currentUser.likedRecipeIds.add(recipeId);
    } else {
      currentUser.likedRecipeIds.remove(recipeId);
    }
  }

  void updateSavedRecipe(String recipeId, bool option) {
    if (option) {
      currentUser.savedRecipeIds.add(recipeId);
    } else {
      currentUser.savedRecipeIds.remove(recipeId);
    }
  }

  void deleteSelfRecipe(String recipeId) {
    currentUser.recipeIds.remove(recipeId);
  }
}
