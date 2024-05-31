part of 'verified_chefs_bloc.dart';

@immutable
sealed class VerifiedChefsState {
  bool isLastPage = false;
}

final class VerifiedChefsInitial extends VerifiedChefsState {}

class VerifiedChefsLoadingState extends VerifiedChefsState {
  VerifiedChefsLoadingState() {
    isLastPage = false;
  }
}

class VerifiedChefsLoadedState extends VerifiedChefsState {
  List<ChefEntity> verifiedChefList = [];

  VerifiedChefsLoadedState(this.verifiedChefList) {
    if (verifiedChefList.length < 10) {
      isLastPage = true;
    }
  }
}

class VerifiedChefsErrorState extends VerifiedChefsState {
  Failure failure;

  VerifiedChefsErrorState(this.failure);
}

class VerifiedChefsActionState extends VerifiedChefsState {}

class VerifiedChefsFollowSuccessState extends VerifiedChefsActionState {
  UpdateFollowObject object;

  VerifiedChefsFollowSuccessState(this.object);
}
