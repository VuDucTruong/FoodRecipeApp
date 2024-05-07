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

  LoginFailure({required this.errorMessage});
}

final class LoginWithGoogleFailure extends LoginFailure {
  final ThirdPartySignInAccount? googleSignInAccount;

  LoginWithGoogleFailure(
      {required String errorMessage, required this.googleSignInAccount})
      : super(errorMessage: errorMessage);
}

class ThirdPartySignInAccount {
  final String email;
  final String name;
  final String id;
  final String? photoUrl;
  final String linkedAccountType;

  ThirdPartySignInAccount(
      {required this.email,
      required this.name,
      required this.id,
      required this.photoUrl,
      required this.linkedAccountType});
  ThirdPartySignInAccount.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        name = json['name'] as String,
        id = json['id'] as String,
        photoUrl = json['picture']['data']['url'] as String,
        linkedAccountType = 'google';
}
