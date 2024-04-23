part of 'verified_chefs_bloc.dart';

@immutable
sealed class VerifiedChefsState {}

final class VerifiedChefsInitial extends VerifiedChefsState {}

class VerifiedChefsLoadingState extends VerifiedChefsState {}

class VerifiedChefsLoadedState extends VerifiedChefsState {
  List<ChefEntity> verifiedChefList = [];

  VerifiedChefsLoadedState(this.verifiedChefList);
}

class VerifiedChefsErrorState extends VerifiedChefsState {
  Failure failure;

  VerifiedChefsErrorState(this.failure);
}
