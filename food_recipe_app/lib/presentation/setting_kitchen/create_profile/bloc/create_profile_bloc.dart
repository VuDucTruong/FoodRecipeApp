import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/usecase/signup_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:meta/meta.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final SignupWithEmailUseCase _signupUseCase;


  CreateProfileBloc({required SignupWithEmailUseCase signupUseCase}) :
      _signupUseCase = signupUseCase,
        super(CreateProfileInitial()) {
    on<CreateProfileOnContinue>(_onCreateProfileContinue);
    on<CreateProfileInitialLoad>(_onCreateProfileInitialLoad);
    on<CreateProfileSubmit>(_onCreateProfileSubmit);
    on<CreateProfileOnNavigate>(_onCreateProfileNavigate);
  }

  FutureOr<void> _onCreateProfileContinue(
      CreateProfileOnContinue event, Emitter<CreateProfileState> emit) {
    emit(CreateProfileSubmitInitial());
  }

  FutureOr<void> _onCreateProfileInitialLoad(
      CreateProfileInitialLoad event, Emitter<CreateProfileState> emit) {
    emit(CreateProfileLoading());
    if(event.id==null)
      {
        emit(CreateProfileLoadingFailure(errorMessage: "Id is null"));
      }
    else
      {
        assert(event.id!=null);
        emit(CreateProfileSubmitSuccess());
      }
  }

  FutureOr<void> _onCreateProfileSubmit(
      CreateProfileSubmit event, Emitter<CreateProfileState> emit) {
    emit(CreateProfileLoading());
    final loginId = event.loginId;
    final name = event.name;
    final email = event.email;
    final password = event.password;
    final bio = event.bio;
    final File? file = event.file;
    if(loginId==null)
      {
        debugPrint('in login id is null');
        if(email==null||password==null||name.isEmpty)
        {
          emit(ErrorTextInputState(errorMessage: "Email, Password or Name is empty"));
          return Future<void>.value();
        }
        debugPrint("Email: $email, Password: $password, Name: $name, Bio: $bio, File: $file");
        debugPrint('calling api');
        _signupUseCase.execute(SignupUseCaseInput(
          email: email, password: password,
          fullName: name, bio: bio, file: file,
        )).then((value) {
          value.fold((l) {
            emit(CreateProfileLoadingFailure(errorMessage: l.message));
          }, (r) {
            emit(CreateProfileSubmitSuccess());
          });
        });
      }
    else
      {
      }

    emit(CreateProfileLoadingSuccess(UserRegisterProfile(
      loginId: "",
      email: email??"",
      fullName: name,
      bio: bio,
      password: password??"",
      file: file,
    )));
  }

  FutureOr<void> _onCreateProfileNavigate(
      CreateProfileOnNavigate event, Emitter<CreateProfileState> emit) {
    emit(CreateProfileSubmitNavigateOptional());
  }

}
