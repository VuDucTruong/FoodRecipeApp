import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:meta/meta.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  CreateProfileBloc() : super(CreateProfileInitial()) {
    on<InputText>(this._onInputText);
  }

  FutureOr<void> _onInputText(
      InputText event, Emitter<CreateProfileState> emit) {
    String? errorMessage = event.validator(event.textInput);
    if (errorMessage != null) {
      emit(ErrorTextInputState(errorMessage: errorMessage));
    }
    emit(CreateProfileInitial());
  }
}
