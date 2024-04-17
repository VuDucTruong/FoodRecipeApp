part of 'recipes_by_category_bloc.dart';

@immutable
sealed class RecipesByCategoryEvent {}

class CategorySelected extends RecipesByCategoryEvent {
  String category;

  CategorySelected(this.category);
}
