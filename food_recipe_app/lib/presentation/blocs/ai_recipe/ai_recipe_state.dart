part of 'ai_recipe_bloc.dart';

@immutable
sealed class AIRecipeState {}

final class AIRecipeInitial extends AIRecipeState {}

class AIRecipeLoadingState extends AIRecipeState {}

class AIRecipeLoadedState extends AIRecipeState {
  RecipeEntity recipe;

  AIRecipeLoadedState(this.recipe);
}

class AIRecipeErrorState extends AIRecipeState {
  Failure failure;

  AIRecipeErrorState(this.failure);
}
