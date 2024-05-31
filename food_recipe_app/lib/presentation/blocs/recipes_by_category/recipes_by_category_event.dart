part of 'recipes_by_category_bloc.dart';

@immutable
sealed class RecipesByCategoryEvent {}

class CategorySelected extends RecipesByCategoryEvent {
  RecipeSearchObject object;

  CategorySelected(this.object);
}

class ConinueLoadingRecipes extends RecipesByCategoryEvent {
  RecipeSearchObject object;

  ConinueLoadingRecipes(this.object);
}
