part of 'user_recipes_bloc.dart';


@immutable
sealed class UserRecipesState {}

final class UserRecipesInitial extends UserRecipesState {}

class UserRecipesLoadingState extends UserRecipesState {

}

class UserRecipesLoadedState extends UserRecipesState {
  List<RecipeEntity> recipeList;

  UserRecipesLoadedState(this.recipeList);
}

class UserRecipesErrorState extends UserRecipesState {
  Failure failure;

  UserRecipesErrorState(this.failure);
}