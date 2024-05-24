part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}


class UserGeneralProfileState extends UserProfileState {}

class GeneralProfileLoadingState extends UserGeneralProfileState {}

class GeneralProfileSuccessState extends UserGeneralProfileState{}

class GeneralProfileErrorState extends UserGeneralProfileState{
  Failure failure;

  GeneralProfileErrorState(this.failure);
}

class UserPasswordState extends UserProfileState {}

class UserPasswordLoadingState extends UserPasswordState{}

class UserPasswordChangedState extends UserPasswordState{}

class UserPasswordErrorState extends UserPasswordState{
  Failure failure;

  UserPasswordErrorState(this.failure);
}