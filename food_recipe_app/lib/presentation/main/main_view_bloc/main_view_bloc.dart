import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_user_info_usecase.dart';
import 'package:meta/meta.dart';

part 'main_view_event.dart';
part 'main_view_state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  final GetUserInfoUseCase _getUserInfoUseCase;

  MainViewBloc(this._getUserInfoUseCase) : super(MainViewInitialEvent()) {
    on<MainInitialEvent>(_mainViewFirstLoadEvent);
  }

  FutureOr<void> _mainViewFirstLoadEvent(
      MainInitialEvent event, Emitter<MainViewState> emit) async {
    emit(MainViewLoadingEvent());
    try{
      //add the state that
      //in bloc consumer
      //if see the user, then update to background data
      //else try to call for the user again
      // if can't find bring user to login page
      final result = await _getUserInfoUseCase.execute(null);
      result.fold(
          (failure) => emit(MainViewErrorEvent(failure)),
          (userEntity) => emit(MainViewSuccessEvent(userEntity)));
    }
    catch(e){
      emit(MainViewErrorEvent(Failure(0,"Error: $e")));
    }
  }
}

void HandleUserSuccess(UserEntity userEntity) {
  BackgroundDataManager.user = userEntity;
}