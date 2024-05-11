import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_email_usecase.dart';
import 'package:food_recipe_app/domain/usecase/signup_with_loginId_usecase.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/create_profile_view.dart';

part 'food_type_event.dart';
part 'food_type_state.dart';

class FoodTypeBloc extends Bloc<FoodTypeEvent, FoodTypeState> {
  final SignupWithEmailUseCase _signupWithEmailUseCase;
  final SignupWithLoginIdUseCase _signupWithLoginIdUseCase;

  FoodTypeBloc({
    required SignupWithEmailUseCase signupUseCase,
    required SignupWithLoginIdUseCase signupWithLoginIdUseCase,}) :
        _signupWithEmailUseCase = signupUseCase,
        _signupWithLoginIdUseCase = signupWithLoginIdUseCase,super(FoodTypeInitial()) {
    on<FoodTypeSubmit>(_onProfileSubmit);
  }
  Future<FutureOr<void>> _onProfileSubmit(
      FoodTypeSubmit event, Emitter<FoodTypeState> emit) async {
    emit(FoodTypeLoading());
    final userProfile = event.userRegisterProfile;
    final String? loginId = userProfile.loginId;
    final String fullName = userProfile.fullName;
    final String? email = userProfile.email;
    final String? password = userProfile.password;
    final String bio = userProfile.bio;
    final String? avatarUrl = userProfile.avatarUrl;
    final MultipartFile? file = userProfile.file;
    final bool isVegan =  userProfile.isVegan;
    final int hungryHeads = userProfile.hungryHeads;
    final List<String> categories = userProfile.categories;
    if(loginId==null)
    {
      debugPrint('in login id is null');
      if(email==null||password==null||fullName.isEmpty)
      {
        emit(FoodTypeSubmitFailure(errorMessage: "Email, Password or Name is empty"));
        return null;
      }
      debugPrint("Email: $email, Password: $password, Name: $fullName, Bio: $bio, File: $file");
      await _signupWithEmailUseCase.execute(SignupWithEmailUseCaseInput(
        email: email, password: password,
        fullName: fullName, bio: bio,
        avatarUrl: avatarUrl??"", file: file,
        isVegan: isVegan, hungryHeads: hungryHeads,
        categories: categories,
      )).then((value) {
        value.fold((l) {
          emit(FoodTypeSubmitFailure(errorMessage: l.message));
        }, (r) {
          emit(FoodTypeSubmitSuccess());
        });
      });
    }
    else // login id not null
        {
      await _signupWithLoginIdUseCase.execute(SignupWithLoginIdUseCaseInput(
        loginId: loginId,linkedAccountType: userProfile.linkedAccountType,
        fullName: fullName, bio: bio,
        avatarUrl: avatarUrl??"", file: file,
        isVegan: isVegan, hungryHeads: hungryHeads,
        categories: categories,))
          .then((value) {value.fold(
          (l) { emit(FoodTypeSubmitFailure(errorMessage: l.message));},
          (r) {emit(FoodTypeSubmitSuccess());});
      }).catchError((e){
        debugPrint('Error in food type bloc: ${e.toString()}');
        emit(FoodTypeSubmitFailure(errorMessage: e.toString()));
      });
    }
  }
}
