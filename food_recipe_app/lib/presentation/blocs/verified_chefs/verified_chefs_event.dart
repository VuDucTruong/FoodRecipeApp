part of 'verified_chefs_bloc.dart';

@immutable
sealed class VerifiedChefsEvent {}

class SearchChefs extends VerifiedChefsEvent {
  UserSearchObject object;

  SearchChefs(this.object);
}

class ContinueSearchingChefs extends VerifiedChefsEvent {
  UserSearchObject object;

  ContinueSearchingChefs(this.object);
}

class UpdateFollowChef extends VerifiedChefsEvent {
  UpdateFollowObject object;

  UpdateFollowChef(this.object);
}
