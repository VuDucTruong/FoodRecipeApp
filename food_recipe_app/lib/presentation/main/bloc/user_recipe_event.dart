part of 'user_recipe_bloc.dart';

@immutable
sealed class UserRecipeEvent {}


class UnsaveRecipe extends UserRecipeEvent{}

class DeleteRecipe extends UserRecipeEvent{}

