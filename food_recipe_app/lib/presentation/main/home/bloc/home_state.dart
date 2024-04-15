part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<RecipeResponse> recipeList = [];
}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  List<RecipeEntity> trendingRecipeList = [];

  HomeLoadingSuccessState(this.trendingRecipeList);
}

class HomeErrorState extends HomeState {
  Failure failure;

  HomeErrorState({required this.failure});
}
