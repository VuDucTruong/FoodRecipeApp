part of 'user_recipes_bloc.dart';

@immutable
sealed class UserRecipesEvent {}

class LoadUserRecipesByIds extends UserRecipesEvent{
  List<String> idList;

  LoadUserRecipesByIds(this.idList);
}