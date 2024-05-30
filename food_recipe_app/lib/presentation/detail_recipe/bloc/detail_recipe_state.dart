part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeState {}

final class DetailRecipeInitial extends DetailRecipeState {}

class DetailRecipeActionState extends DetailRecipeState {}

class RecipeLikeFailState extends DetailRecipeActionState {
  Failure failure;

  RecipeLikeFailState(this.failure);
}

class RecipeLikeSuccessState extends DetailRecipeActionState {
  bool isLike;

  RecipeLikeSuccessState(this.isLike);
}

class RecipeSaveFailState extends DetailRecipeActionState {
  Failure failure;

  RecipeSaveFailState(this.failure);
}

class RecipeSaveSuccessState extends DetailRecipeActionState {
  bool isSave;

  RecipeSaveSuccessState(this.isSave);
}
