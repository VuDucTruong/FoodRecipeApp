part of 'saved_recipes_bloc.dart';

@immutable
sealed class SavedRecipesState {
  bool isLastPage = false;
}

final class SavedRecipesInitial extends SavedRecipesState {}

class UserSavedRecipesState extends SavedRecipesState {}

class UserSavedRecipeActionState extends SavedRecipesState{}

class SavedRecipesLoadingState extends UserSavedRecipesState {
  SavedRecipesLoadingState() {
    super.isLastPage = false;
  }
}

class SavedRecipesLoadedState extends UserSavedRecipesState {
  List<RecipeEntity> savedRecipeList = [];

  SavedRecipesLoadedState(this.savedRecipeList) {
    if (savedRecipeList.isEmpty) {
      super.isLastPage = true;
    }
  }
}

class SavedRecipesErrorState extends UserSavedRecipesState {
  Failure failure;
  SavedRecipesErrorState(this.failure);
}


class SavedRecipeUpdatingState extends UserSavedRecipeActionState {

}

class SavedRecipeUpdatedState extends UserSavedRecipeActionState {
  bool isSuccess;

  SavedRecipeUpdatedState(this.isSuccess);
}
class SavedRecipeUpdateErrorState extends UserSavedRecipeActionState {
  Failure failure;

  SavedRecipeUpdateErrorState(this.failure);
}