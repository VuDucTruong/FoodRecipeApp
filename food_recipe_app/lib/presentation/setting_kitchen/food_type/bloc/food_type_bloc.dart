import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_email_usecase.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_loginId_usecase.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/create_profile_view.dart';

part 'food_type_event.dart';
part 'food_type_state.dart';

class FoodTypeBloc extends Bloc<FoodTypeEvent, FoodTypeState> {
  final SignupWithEmailUseCase _signupWithEmailUseCase;
  final SignupWithLoginIdUseCase _signupWithLoginIdUseCase;
  final NetworkInfo _networkInfo;

  FoodTypeBloc({
    required SignupWithEmailUseCase signupUseCase,
    required SignupWithLoginIdUseCase signupWithLoginIdUseCase,
    required NetworkInfo networkInfo,
  })  : _signupWithEmailUseCase = signupUseCase,
        _signupWithLoginIdUseCase = signupWithLoginIdUseCase,
        _networkInfo = networkInfo,
        super(FoodTypeInitial()) {
    on<FoodTypeSubmit>(_onProfileSubmit);
  }

  Future<FutureOr<void>> _onProfileSubmit(
      FoodTypeSubmit event, Emitter<FoodTypeState> emit) async {
    emit(FoodTypeLoading());
    UserRegisterProfileAdvanced userRegisterProfile = event.userRegisterProfile;

try{
  if (await _networkInfo.isConnected) {
    if (userRegisterProfile.loginId == null) {
      if (userRegisterProfile.email != null &&
          userRegisterProfile.password != null &&
          userRegisterProfile.fullName.isNotEmpty) {
        if (await _networkInfo.isConnected) {
          await _signupWithEmailUseCase
              .execute(
              SignupWithEmailUseCaseInput.fromUserRegisterProfileAdvanced(
                  userRegisterProfileAdvanced: event.userRegisterProfile))
              .then((value) {
            value.fold((left) => emit(FoodTypeSubmitFailure(failure: left)),
                    (right) => emit(FoodTypeSubmitSuccess()));
          });
        } else {
          emit(FoodTypeSubmitFailure(
              failure:
              Failure(ResponseCode.DEFAULT, AppStrings.invalidInput)));
        }
      } else {
        emit(FoodTypeSubmitFailure(
            failure: Failure(ResponseCode.DEFAULT, AppStrings.invalidInput)));
      }
    } else // login id not null
        {
      await _signupWithLoginIdUseCase
          .execute(
          SignupWithLoginIdUseCaseInput.fromUserRegisterProfileAdvanced(
              userRegisterProfileAdvanced: event.userRegisterProfile))
          .then((value) {
        value.fold((left) {
          emit(FoodTypeSubmitFailure(failure: left));
        }, (right) {
          emit(FoodTypeSubmitSuccess());
        });
      }).catchError((e) {
        emit(FoodTypeSubmitFailure(
            failure: Failure(ResponseCode.DEFAULT, "API error")));
      });
    }
  }
  else {
    emit(FoodTypeSubmitFailure(
        failure: Failure(ResponseCode.NO_INTERNET_CONNECTION, AppStrings.noInternet)));
  }
}
catch(error){
  debugPrint("Error: ${error}");
}
  }
}
