import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

import '../../domain/entity/background_user.dart';

class BackgroundDataManager {
  BackgroundUser? currentUser;

  ChefEntity convertToChefEntity() {
    return ChefEntity(
        currentUser!.id,
        currentUser!.createdAt,
        currentUser!.profileInfo,
        currentUser!.recipeIds,
        currentUser!.followingIds.length,
        currentUser!.followerIds.length);
  }

  void setBackgroundUser(BackgroundUser user) {
    currentUser = user;
  }

  BackgroundUser getBackgroundUser() {
    return currentUser!;
  }

  void updateFollow(String chefId, bool option) {
    if (option) {
      currentUser!.followingIds.add(chefId);
    } else {
      currentUser!.followingIds.remove(chefId);
    }
    print("In backgournd : ${currentUser!.followingIds.contains(chefId)}");
  }

  void updateProfile(ProfileInformation profileInformation) {
    currentUser!.profileInfo = profileInformation;
  }

  void updateLikeRecipe(String recipeId, bool option) {
    if (option) {
      currentUser!.likedRecipeIds.add(recipeId);
    } else {
      currentUser!.likedRecipeIds.remove(recipeId);
    }
  }

  void updateSavedRecipe(String recipeId, bool option) {
    if (option) {
      currentUser!.savedRecipeIds.add(recipeId);
    } else {
      currentUser!.savedRecipeIds.remove(recipeId);
    }
  }

  void deleteSelfRecipe(String recipeId) {
    currentUser!.recipeIds.remove(recipeId);
  }
}
