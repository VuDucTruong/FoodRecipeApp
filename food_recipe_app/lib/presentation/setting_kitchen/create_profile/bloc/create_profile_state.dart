part of 'create_profile_bloc.dart';

@immutable
sealed class CreateProfileState {}

final class CreateProfileInitial extends CreateProfileState {}

class ErrorTextInputState extends CreateProfileState {
  String? errorMessage;

  ErrorTextInputState({this.errorMessage});
}
