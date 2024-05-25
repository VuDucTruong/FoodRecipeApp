import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/usecase/delete_user_profile_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_user_profile_usecase.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {

  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final DeleteUserProfileUseCase _deleteUserProfileUseCase;
  final BackgroundDataManager _backgroundDataManager;


  EditProfileBloc({
    required UpdateUserProfileUseCase updateUserProfileUseCase,
    required DeleteUserProfileUseCase deleteUserProfileUseCase,
    required BackgroundDataManager backgroundDataManager,
  }) : _updateUserProfileUseCase = updateUserProfileUseCase,
        _deleteUserProfileUseCase = deleteUserProfileUseCase,
        _backgroundDataManager = backgroundDataManager,
        super(EditProfileInitial()) {
    on<EditProfileInitialLoadEvent>(_onEditProfileInitialLoad);
    on<EditProfileSubmitEvent>(_onEditProfileSubmit);
    on<EditProfileDeleteEvent>(_onEditProfileDelete);
  }

  FutureOr<void> _onEditProfileInitialLoad(
      EditProfileInitialLoadEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      final result = _backgroundDataManager.getBackgroundUser();
      emit(EditProfileInitialLoadSuccess(result.profileInfo));
    } catch (e) {
      emit(EditProfileInitialLoadFailed(Failure.actionFailed('Load profile failed')));
    }
  }

  FutureOr<void> _onEditProfileSubmit(
      EditProfileSubmitEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());

    try{

      if(event.avatar != null){
        debugPrint('avatar is not null IN BLOC');
      }
      else
        debugPrint('avatar is null IN BLOC');

      final result = await _updateUserProfileUseCase.execute(
          UpdateProfileUseCaseInput(event.profileInformation, event.avatar));
      result.fold(
              (failure) => emit(EditProfileSubmitFailed(failure)),
              (success) => emit(EditProfileSubmitSuccess(success))
      );
    } catch (e) {
      emit(EditProfileSubmitFailed(Failure.actionFailed('Update profile failed')));
    }
  }

  FutureOr<void> _onEditProfileDelete(
      EditProfileDeleteEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());

    try{
      final result = await _deleteUserProfileUseCase.execute(null);
      result.fold(
              (failure) => emit(EditProfileDeleteFailed(failure)),
              (success) => emit(EditProfileDeleteSuccess())
      );
    } catch (e) {
      emit(EditProfileDeleteFailed(Failure.actionFailed('Delete profile failed')));
    }
  }
}
