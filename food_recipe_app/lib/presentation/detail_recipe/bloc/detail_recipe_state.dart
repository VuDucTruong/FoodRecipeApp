part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeState {}

final class DetailRecipeInitial extends DetailRecipeState {}

class DetailRecipeActionState extends DetailRecipeState {}

class DetailRecipeLoadingState extends DetailRecipeState {}

class DetailRecipeLoadedState extends DetailRecipeState {}

class DetailRecipeErrorState extends DetailRecipeState {}

class DetailRecipeLikeState extends DetailRecipeActionState {}

class RecipeLikeSuccessState extends DetailRecipeLikeState {}

class RecipeLikeFailState extends DetailRecipeLikeState {}

class DetailRecipeSaveState extends DetailRecipeActionState {}

class RecipeSaveSuccessState extends DetailRecipeSaveState {}

class RecipeSaveFailState extends DetailRecipeSaveState {}
