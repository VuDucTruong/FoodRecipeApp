part of 'chef_info_bloc.dart';

@immutable
sealed class ChefInfoEvent {}

class LoadChefInfoById extends ChefInfoEvent {
  String id;

  LoadChefInfoById(this.id);
}

class LoadChefRecipes extends ChefInfoEvent {
  List<String> recipeIdList;

  LoadChefRecipes(this.recipeIdList);
}

class UpdateFollowChef extends ChefInfoEvent {
  ChefEntity chefEntity;
  UpdateFollowObject object;

  UpdateFollowChef(this.object, this.chefEntity) {
    chefEntity.followerCount += object.option ? 1 : -1;
  }
}
