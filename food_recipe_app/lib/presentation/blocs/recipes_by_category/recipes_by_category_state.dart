part of 'recipes_by_category_bloc.dart';

@immutable
sealed class RecipesByCategoryState {}

final class RecipesByCategoryInitial extends RecipesByCategoryState {}

class RecipesByCategoryLoadingState extends RecipesByCategoryState {}

class RecipesByCategoryLoadedState extends RecipesByCategoryState {
  List<RecipeEntity> recipesByCategory = [];

  RecipesByCategoryLoadedState(this.recipesByCategory);
}

class RecipesByCategoryErrorState extends RecipesByCategoryState {
  Failure failure;

  RecipesByCategoryErrorState(this.failure);
}
