import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/usecase/facebook_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/google_login_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe_app/domain/usecase/login_usecase.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final FacebookLoginUseCase _facebookLoginUseCase;
  final FacebookAuth _facebookAuth;
  final GoogleSignIn _googleSignIn;

  LoginBloc({required LoginUseCase loginUseCase,
  required GoogleLoginUseCase googleLoginUseCase,
  required FacebookLoginUseCase facebookLoginUseCase,
  required GoogleSignIn googleSignIn,
  required FacebookAuth facebookAuth }) :
        _loginUseCase = loginUseCase,
        _googleLoginUseCase = googleLoginUseCase,
        _facebookLoginUseCase = facebookLoginUseCase,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth,
        super(LoginInitial())
  {
    on<LoginButtonPressed>(_loginPressed);
    on<LoginWithGooglePressed>(_loginWithGooglePressed);
    on<LoginWithFacebookPressed>(_loginWithFacebookPressed);
  }

  FutureOr<void> _loginPressed(LoginButtonPressed loginButtonPressed,
      Emitter<LoginState> emit) async
  {
    var email = loginButtonPressed.email;
    var password = loginButtonPressed.password;
    // Show loading state
    emit(LoginLoading());
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final result = await _loginUseCase.execute(LoginUseCaseInput(
          email: email,
          password: password,
        ));
        result.fold(
            (failure)=> emit(LoginFailure(errorMessage: failure.message)),
            (userEntity)=>emit(LoginSuccess(userEntity)) );
      } catch (e) {
        // Error occurred during login
        emit(LoginFailure(errorMessage: "Login Failed: $e"));
      }
    } else {
      // Empty email or password, show error state
      emit(LoginFailure(errorMessage: "Email password requires"));
    }
  }

  FutureOr<void> _loginWithGooglePressed(LoginWithGooglePressed loginWithGooglePressed,
      Emitter<LoginState> emit) async {
    // Show loading state
    emit(LoginLoading());
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount == null){
        emit(LoginFailure(errorMessage: "Google Sign In Failed"));
        return;
      }
      debugPrint("Google Sign In Account: ${googleSignInAccount.id}");
      final request = GoogleLoginUseCaseInput(loginId: googleSignInAccount.id);
      final result = await _googleLoginUseCase.execute(request);
      result.fold(
              (failure)=> emit(LoginWithGoogleFailure(
                  errorMessage: 'not found linked account',
                  googleSignInAccount: ThirdPartySignInAccount(
                      email: googleSignInAccount.email,
                      name: googleSignInAccount.displayName??"",
                      id: googleSignInAccount.id
                  ))),
              (userEntity)=>emit(LoginSuccess(userEntity)) );
      }
      catch(e){
        // Error occurred during login
        emit(LoginFailure(errorMessage: "Login Failed: $e"));
      }
  }
  FutureOr<void> _loginWithFacebookPressed(LoginWithFacebookPressed loginWithFacebookPressed,
      Emitter<LoginState> emit) async {
    // Show loading state
    emit(LoginLoading());
    try {
      // final facebookSignInAccount = await _facebookAuth.login(
      //   permissions: ["public_profile"],
      // );
      final accountInfo = await _facebookAuth.getUserData(fields: "id,name,email,picture.width(200).height(200)");
      debugPrint("Facebook Account Info: $accountInfo");
      if(accountInfo["id"] == null){
        emit(LoginFailure(errorMessage: "Facebook Sign In Failed"));
        return;
      }
      final request = FacebookLoginUseCaseInput(loginId: accountInfo['email'].toString());
      final result = await _facebookLoginUseCase.execute(request);
      result.fold(
              (failure)=> emit(LoginWithFacebookFailure(errorMessage: failure.message,
                  facebookSignInAccount: ThirdPartySignInAccount.fromJson(accountInfo))),
              (userEntity)=>emit(LoginSuccess(userEntity)) );
    }
    catch(e){
      // Error occurred during login
      emit(LoginFailure(errorMessage: "Login Failed: $e"));
    }
  }
}


