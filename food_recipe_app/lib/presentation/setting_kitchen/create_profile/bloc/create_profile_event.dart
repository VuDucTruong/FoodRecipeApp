part of 'create_profile_bloc.dart';

@immutable
sealed class CreateProfileEvent {}

class CreateProfileInitialLoad extends CreateProfileEvent {
  final String? id;
  final String? email;
  final String? name;
  CreateProfileInitialLoad({this.id, this.email, this.name});
}

class CreateProfileOnContinue extends CreateProfileEvent {}

class CreateProfileSubmit extends CreateProfileEvent {
  final String? loginId;
  final String name;
  final String? email;
  final String? password;
  final String bio;
  final File? file;

  CreateProfileSubmit(
      {
        required this.name,
        required this.bio,
      this.loginId,
      this.email,
      this.password,
      this.file,});
}

class CreateProfileOnNavigate extends CreateProfileEvent {}

