part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final UserEntity userEntity;

  LoginSuccess(this.userEntity);
}
final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}
