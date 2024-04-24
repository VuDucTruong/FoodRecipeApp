part of 'create_recipe_bloc.dart';

@immutable
sealed class CreateRecipeEvent {}

class CreateRecipeButtonPressed extends CreateRecipeEvent {
  CreateRecipeObject object;

  CreateRecipeButtonPressed(this.object);
}
