import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/background_data/device_info.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe_app/domain/usecase/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_loginPressed);
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
            (failure)=> emit(LoginFailure(failure.message)),
            (useEntity)=>emit(LoginSuccess(useEntity)) );
      } catch (e) {
        // Error occurred during login
        emit(LoginFailure("Login Failed: $e"));
      }
    } else {
      // Empty email or password, show error state
      emit(LoginFailure("Email and password are required."));
    }
  }


}
