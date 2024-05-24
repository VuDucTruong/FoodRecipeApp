import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecase/update_password_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UpdatePasswordUseCase updatePasswordUseCase;


  UserProfileBloc(this.updatePasswordUseCase) : super(UserProfileInitial()) {
    on<UserGeneralProfileSaveButtonPressed>(_onGeneralSaveButtonPressed);
    on<ChangeUserPassword>(_onChangePassword);
  }

  FutureOr<void> _onGeneralSaveButtonPressed(UserGeneralProfileSaveButtonPressed event, Emitter<UserProfileState> emit) {
    emit(GeneralProfileLoadingState());

  }

  Future<FutureOr<void>> _onChangePassword(ChangeUserPassword event, Emitter<UserProfileState> emit) async {
    emit(UserPasswordLoadingState());
    (await updatePasswordUseCase.execute(event.newPassword)).fold((l) => emit(UserPasswordErrorState(l)), (r) => emit(UserPasswordChangedState()),);
  }
}
