import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_chefs_from_rank_usecase.dart';
import 'package:meta/meta.dart';

part 'verified_chefs_event.dart';
part 'verified_chefs_state.dart';

class VerifiedChefsBloc extends Bloc<VerifiedChefsEvent, VerifiedChefsState> {
  GetChefsFromRankUseCase getChefsFromRankUseCase;

  VerifiedChefsBloc(this.getChefsFromRankUseCase)
      : super(VerifiedChefsInitial()) {
    on<VerifiedChefsLoad>(_onVerifiedChefsLoad);
  }

  Future<FutureOr<void>> _onVerifiedChefsLoad(
      VerifiedChefsLoad event, Emitter<VerifiedChefsState> emit) async {
    emit(VerifiedChefsLoadingState());
    (await getChefsFromRankUseCase.execute(null)).fold(
        (l) => emit(VerifiedChefsErrorState(l)),
        (r) => emit(VerifiedChefsLoadedState(r)));
  }
}
