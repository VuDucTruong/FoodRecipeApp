import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_chef_info_by_id_usecase.dart';
import 'package:meta/meta.dart';

part 'chef_info_event.dart';
part 'chef_info_state.dart';

class ChefInfoBloc extends Bloc<ChefInfoEvent, ChefInfoState> {
  GetChefInfoByIdUseCase getChefInfoByIdUseCase;

  ChefInfoBloc(this.getChefInfoByIdUseCase) : super(ChefInfoInitial()) {
    on<LoadChefInfoById>(_onLoadById);
  }

  Future<FutureOr<void>> _onLoadById(
      LoadChefInfoById event, Emitter<ChefInfoState> emit) async {
    emit(ChefInfoLoadingState());
    (await getChefInfoByIdUseCase.execute(event.id)).fold(
        (l) => emit(ChefInfoErrorState(l)),
        (r) => emit(ChefInfoLoadedState(r)));
  }
}
