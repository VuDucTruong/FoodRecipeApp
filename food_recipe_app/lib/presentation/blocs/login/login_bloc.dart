import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/usecase/google_login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/login_usecase.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final GoogleSignIn _googleSignIn;
  final NetworkInfo _networkInfo;
  final BackgroundDataManager _backgroundDataManager;
  LoginBloc(
      {required LoginUseCase loginUseCase,
      required GoogleLoginUseCase googleLoginUseCase,
      required GoogleSignIn googleSignIn,
      required NetworkInfo networkInfo,
      required BackgroundDataManager backgroundDataManager})
      : _loginUseCase = loginUseCase,
        _googleLoginUseCase = googleLoginUseCase,
        _googleSignIn = googleSignIn,
        _networkInfo = networkInfo,
        _backgroundDataManager = backgroundDataManager,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_loginPressed);
    on<LoginWithGooglePressed>(_loginWithGooglePressed);
  }

  FutureOr<void> _loginPressed(
      LoginButtonPressed loginButtonPressed, Emitter<LoginState> emit) async {
    var email = loginButtonPressed.email;
    var password = loginButtonPressed.password;
    // Show loading state
    emit(LoginLoading());
    if (await _networkInfo.isConnected) {
      try {
        final result = await _loginUseCase.execute(LoginUseCaseInput(
          email: email,
          password: password,
        ));
        result.fold((failure) => emit(LoginFailure(failure: failure)),
            (userEntity) {
          _backgroundDataManager.setBackgroundUser(
              BackgroundUser.fromUserEntity(userEntity: userEntity));
          emit(LoginSuccess(userEntity));
        });
      } catch (e) {
        // Error occurred during login
        emit(LoginFailure(
            failure: Failure(ResponseCode.DEFAULT, AppStrings.loginError)));
      }
    } else {
      emit(LoginFailure(failure: Failure.noInternet()));
    }
  }

  FutureOr<void> _loginWithGooglePressed(
      LoginWithGooglePressed loginWithGooglePressed,
      Emitter<LoginState> emit) async {
    // Show loading state
    emit(LoginLoading());
    if (await _networkInfo.isConnected) {
      try {
        await _googleSignIn.signOut();
        final googleSignInAccount = await _googleSignIn.signIn();
        if (googleSignInAccount == null) {
          emit(LoginFailure(failure: Failure.dataNotFound("Google Account")));
          return;
        }
        final request =
            GoogleLoginUseCaseInput(loginId: googleSignInAccount.id);
        final result = await _googleLoginUseCase.execute(request);
        result.fold(
            (failure) => emit(LoginWithGoogleFailure(
                failure: failure,
                googleSignInAccount:
                    ThirdPartySignInAccount.fromGoogleSignInAccount(
                        googleSignInAccount))), (userEntity) {
          _backgroundDataManager.setBackgroundUser(
              BackgroundUser.fromUserEntity(userEntity: userEntity));
          emit(LoginSuccess(userEntity));
        });
      } catch (e) {
        // Error occurred during login
        emit(LoginFailure(failure: Failure.notFound()));
      }
    } else {
      emit(LoginFailure(failure: Failure.noInternet()));
    }
  }
}
