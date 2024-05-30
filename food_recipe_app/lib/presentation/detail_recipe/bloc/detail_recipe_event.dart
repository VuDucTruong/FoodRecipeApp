part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeEvent {}

class UpdateLikeStatus extends DetailRecipeEvent {}

class UpdateSaveStatus extends DetailRecipeEvent {}
