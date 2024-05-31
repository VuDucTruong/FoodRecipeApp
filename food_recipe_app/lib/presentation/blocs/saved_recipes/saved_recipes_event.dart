part of 'saved_recipes_bloc.dart';

@immutable
sealed class SavedRecipesEvent {}

class SavedRecipesCategorySelected extends SavedRecipesEvent {
  RecipeSearchObject object;

  SavedRecipesCategorySelected(this.object);
}

class SavedRecipesConinueLoading extends SavedRecipesEvent {
  RecipeSearchObject object;

  SavedRecipesConinueLoading(this.object);
}

class LoadMyRecipes extends SavedRecipesEvent {
  RecipeSearchObject object;

  LoadMyRecipes({required this.object});
}

class MyRecipesContinueLoading extends SavedRecipesEvent {
  RecipeSearchObject object;

  MyRecipesContinueLoading(this.object);
}

class DeleteUserRecipe extends SavedRecipesEvent {
  RecipeEntity recipeEntity;

  DeleteUserRecipe(this.recipeEntity);
}
