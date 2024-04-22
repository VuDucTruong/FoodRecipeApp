part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email,
    required this.password});
}

class LoginWithGooglePressed extends LoginEvent {}
class LoginWithFacebookPressed extends LoginEvent {}