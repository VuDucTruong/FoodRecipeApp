part of 'create_recipe_bloc.dart';

@immutable
sealed class CreateRecipeState {}

final class CreateRecipeInitial extends CreateRecipeState {}

class CreateRecipeLoadingState extends CreateRecipeState {}

class CreateRecipeSuccessState extends CreateRecipeState {
  RecipeEntity recipeEntity;

  CreateRecipeSuccessState(this.recipeEntity);
}

class CreateRecipeErrorState extends CreateRecipeState {
  Failure failure;

  CreateRecipeErrorState(this.failure);
}
