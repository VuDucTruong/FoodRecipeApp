part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent {}

class ChangePasswordSubmitEvent extends ChangePasswordEvent {
  final String newPassword;

  ChangePasswordSubmitEvent( this.newPassword);
}