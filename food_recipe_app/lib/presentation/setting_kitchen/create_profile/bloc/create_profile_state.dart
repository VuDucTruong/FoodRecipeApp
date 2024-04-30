part of 'create_profile_bloc.dart';

@immutable
sealed class CreateProfileState {}

final class CreateProfileInitial extends CreateProfileState {}

final class CreateProfileLoading extends CreateProfileState {}
final class CreateProfileLoadingSuccess extends CreateProfileState {
  final UserRegisterProfile userRegisterProfile;

  CreateProfileLoadingSuccess(this.userRegisterProfile);
}
final class CreateProfileLoadingFailure extends CreateProfileState {
  final String errorMessage;

  CreateProfileLoadingFailure({required this.errorMessage});
}

final class CreateProfileSubmitInitial extends CreateProfileState {}
final class CreateProfileSubmitSuccess extends CreateProfileState {}
final class CreateProfileSubmitFailure extends CreateProfileState {
  final String errorMessage;

  CreateProfileSubmitFailure({required this.errorMessage});
}
final class CreateProfileSubmitNavigateOptional extends CreateProfileState{}

final class ErrorTextInputState extends CreateProfileState {
  final String? errorMessage;

  ErrorTextInputState({this.errorMessage});
}

class UserRegisterProfile {
  final String loginId;
  final String email;
  final String password;
  final String fullName;
  final String bio;
  final File? file;

  UserRegisterProfile({
    required this.loginId,
    required this.email,
    required this.password,
    required this.fullName,
    required this.bio,
    this.file,
});
}