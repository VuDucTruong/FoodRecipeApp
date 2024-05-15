part of 'chef_info_bloc.dart';

@immutable
sealed class ChefInfoState {
  ChefEntity? chefEntity;
}

final class ChefInfoInitial extends ChefInfoState {}

class ChefInfoLoadingState extends ChefInfoState {}

class ChefInfoLoadedState extends ChefInfoState {
  ChefInfoLoadedState(ChefEntity chefEntity) {
    super.chefEntity = chefEntity;
  }
}

class ChefInfoErrorState extends ChefInfoState {
  Failure failure;

  ChefInfoErrorState(this.failure) {
    chefEntity = null;
  }
}
