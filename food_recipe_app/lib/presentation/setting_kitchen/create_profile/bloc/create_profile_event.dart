part of 'create_profile_bloc.dart';

@immutable
sealed class CreateProfileEvent {}

class CreateProfileOnContinuePressed extends CreateProfileEvent {
  final String email;
  CreateProfileOnContinuePressed({required this.email});
}