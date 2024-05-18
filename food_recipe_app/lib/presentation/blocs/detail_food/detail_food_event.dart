part of 'detail_food_bloc.dart';

@immutable
sealed class DetailFoodEvent {}

class SaveRecipe extends DetailFoodEvent{}
class LikeRecipe extends DetailFoodEvent{}
class UnlikeRecipe extends DetailFoodEvent{}
class UnsaveRecipe extends DetailFoodEvent{}
