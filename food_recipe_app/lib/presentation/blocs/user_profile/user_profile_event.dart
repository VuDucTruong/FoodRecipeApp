part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}


class UserGeneralProfileSaveButtonPressed extends UserProfileEvent {}

class ChangeUserPassword extends UserProfileEvent {
  String newPassword;

  ChangeUserPassword(this.newPassword);
}