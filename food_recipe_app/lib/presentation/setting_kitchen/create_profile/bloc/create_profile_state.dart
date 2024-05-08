part of 'create_profile_bloc.dart';

@immutable
sealed class CreateProfileState {}

final class CreateProfileInitial extends CreateProfileState {}

final class CreateProfileLoading extends CreateProfileState {}

final class CreateProfileSubmitSuccess extends CreateProfileState {}

final class CreateProfileSubmitFailed extends CreateProfileState {
  final String message;
  CreateProfileSubmitFailed({required this.message});
}