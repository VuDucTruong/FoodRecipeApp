part of 'chef_info_bloc.dart';

@immutable
sealed class ChefInfoState {
  ChefEntity? chefEntity;
}

class ChefProfileState extends ChefInfoState {}

class ChefRecipeState extends ChefInfoState {}

final class ChefInfoInitial extends ChefInfoState {}

class ChefInfoLoadingState extends ChefProfileState {}

class ChefInfoLoadedState extends ChefProfileState {
  ChefInfoLoadedState(ChefEntity chefEntity) {
    super.chefEntity = chefEntity;
  }
}

class ChefInfoErrorState extends ChefProfileState {
  Failure failure;

  ChefInfoErrorState(this.failure);
}

class ChefRecipeLoadingState extends ChefRecipeState {}

class ChefRecipeLoadedState extends ChefRecipeState {
  List<RecipeEntity> recipeList;

  ChefRecipeLoadedState(this.recipeList);
}

class ChefRecipeErrorState extends ChefRecipeState {
  Failure failure;

  ChefRecipeErrorState(this.failure);
}

class VerifiedChefsActionState extends ChefRecipeState {}

class FollowSuccessState extends VerifiedChefsActionState {
  UpdateFollowObject object;

  FollowSuccessState(this.object);
}
