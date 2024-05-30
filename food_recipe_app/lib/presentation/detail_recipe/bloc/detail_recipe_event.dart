part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeEvent {}

class UpdateLikeStatus extends DetailRecipeEvent {
  StatusRecipeObject object;

  UpdateLikeStatus(this.object);
}

class UpdateSaveStatus extends DetailRecipeEvent {
  StatusRecipeObject object;

  UpdateSaveStatus(this.object);
}
