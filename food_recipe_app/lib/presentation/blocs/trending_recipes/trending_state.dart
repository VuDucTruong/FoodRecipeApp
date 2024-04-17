part of 'trending_bloc.dart';

@immutable
sealed class TrendingState {}

final class TrendingInitial extends TrendingState {}

class TrendingLoadingState extends TrendingState {}

class TrendingLoadedState extends TrendingState {
  List<RecipeEntity> trendingList = [];

  TrendingLoadedState(this.trendingList);
}

class TrendingErrorState extends TrendingState {
  Failure failure;

  TrendingErrorState(this.failure);
}
