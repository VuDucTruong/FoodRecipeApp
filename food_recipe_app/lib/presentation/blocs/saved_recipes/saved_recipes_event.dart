part of 'saved_recipes_bloc.dart';

@immutable
sealed class SavedRecipesEvent {}

class SavedRecipesCategorySelected extends SavedRecipesEvent {
  GetSavedRecipesObject getSavedRecipesObject;

  SavedRecipesCategorySelected(this.getSavedRecipesObject);
}

class SavedRecipesConinueLoading extends SavedRecipesEvent {
  GetSavedRecipesObject getSavedRecipesObject;

  SavedRecipesConinueLoading(this.getSavedRecipesObject);
}

class UnSaveRecipe extends SavedRecipesEvent {}
