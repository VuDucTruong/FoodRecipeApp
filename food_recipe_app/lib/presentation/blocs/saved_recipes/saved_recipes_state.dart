part of 'saved_recipes_bloc.dart';

@immutable
sealed class SavedRecipesState {
  bool isLastPage = false;
}

final class SavedRecipesInitial extends SavedRecipesState {}

class SavedRecipesLoadingState extends SavedRecipesState {
  SavedRecipesLoadingState() {
    isLastPage = false;
  }
}

class SavedRecipesLoadedState extends SavedRecipesState {
  List<RecipeEntity> savedRecipeList = [];

  SavedRecipesLoadedState(this.savedRecipeList) {
    if (savedRecipeList.isEmpty) {
      isLastPage = true;
    }
  }
}

class SavedRecipesErrorState extends SavedRecipesState {
  Failure failure;
  SavedRecipesErrorState(this.failure);
}
