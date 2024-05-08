import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/usecase/login_verify_usecase.dart';
import 'package:meta/meta.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final LoginVerifyUseCase _loginVerifyUseCase;

  CreateProfileBloc({required LoginVerifyUseCase loginVerifyUseCase}) :
        _loginVerifyUseCase = loginVerifyUseCase,
        super(CreateProfileInitial()) {
    on<CreateProfileOnContinuePressed>(_onCreateProfileOnContinuePressed);
  }

  FutureOr<void> _onCreateProfileOnContinuePressed
      (CreateProfileOnContinuePressed event, Emitter<CreateProfileState> emit) async {
    try{
      emit(CreateProfileLoading());
      final email = event.email;
      final result = await _loginVerifyUseCase.execute(email);
      result.fold(
            (failure) => emit(CreateProfileSubmitFailed(message: failure.toString())),
            (value) => emit(CreateProfileSubmitSuccess()),
      );
    }catch(e){
      debugPrint('Error: $e');
      emit(CreateProfileSubmitFailed(message: e.toString()));
    }
  }
}
