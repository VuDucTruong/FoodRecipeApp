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
