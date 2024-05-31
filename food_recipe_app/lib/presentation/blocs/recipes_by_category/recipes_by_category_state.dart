part of 'recipes_by_category_bloc.dart';

@immutable
sealed class RecipesByCategoryState {
  bool isLastPage = false;
}

final class RecipesByCategoryInitial extends RecipesByCategoryState {}

class RecipesByCategoryLoadingState extends RecipesByCategoryState {
  RecipesByCategoryLoadingState() {
    isLastPage = false;
  }
}

class RecipesByCategoryLoadedState extends RecipesByCategoryState {
  List<RecipeEntity> recipesByCategory = [];

  RecipesByCategoryLoadedState(this.recipesByCategory) {
    if (recipesByCategory.length < 10) {
      isLastPage = true;
    }
  }
}

class RecipesByCategoryErrorState extends RecipesByCategoryState {
  Failure failure;

  RecipesByCategoryErrorState(this.failure);
}
