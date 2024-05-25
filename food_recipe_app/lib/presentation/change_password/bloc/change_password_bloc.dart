import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/usecase/update_user_password_usecase.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {

  UpdateUserPasswordUseCase _updateUserPasswordUseCase;

  ChangePasswordBloc({required UpdateUserPasswordUseCase updateUserPasswordUseCase}) :
        _updateUserPasswordUseCase = updateUserPasswordUseCase,
        super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitEvent>(_onChangePasswordSubmitEvent);
  }

  FutureOr<void> _onChangePasswordSubmitEvent (ChangePasswordSubmitEvent event,
      Emitter<ChangePasswordState> emit) {
    emit(ChangePasswordLoading());
    try{
      if(event.newPassword.isEmpty){
        emit(ChangePasswordFailure(Failure.actionFailed("Update Password")));
      } else {
        _updateUserPasswordUseCase.execute(event.newPassword);
        emit(ChangePasswordSuccess());
      }
    }
    catch(e){
      emit(ChangePasswordFailure(Failure.actionFailed("Update Password")));
    }
  }
}
