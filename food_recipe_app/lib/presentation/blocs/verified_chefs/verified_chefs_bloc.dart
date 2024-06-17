import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/object/update_follow_object.dart';
import 'package:food_recipe_app/domain/object/user_search_object.dart';
import 'package:food_recipe_app/domain/usecase/get_chefs_by_ids_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_chefs_from_rank_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_search_chefs_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_user_follow_usecase.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'verified_chefs_event.dart';
part 'verified_chefs_state.dart';

class VerifiedChefsBloc extends Bloc<VerifiedChefsEvent, VerifiedChefsState> {
  GetSearchChefsUseCase getSearchChefsUseCase;
  UpdateUserFollowUseCase updateUserFollowUseCase;
  GetChefsByIdsUseCase getChefsByIdsUseCase;

  VerifiedChefsBloc(this.getSearchChefsUseCase, this.updateUserFollowUseCase,
      this.getChefsByIdsUseCase)
      : super(VerifiedChefsInitial()) {
    on<SearchChefs>(_onSearchChefs);
    on<ContinueSearchingChefs>(_onContinueSearching);
    on<UpdateFollowChef>(_onUpdateFollow);
    on<GetChefsByIds>(_onGetChefsByIds);
  }

  Future<FutureOr<void>> _onSearchChefs(
      SearchChefs event, Emitter<VerifiedChefsState> emit) async {
    emit(VerifiedChefsLoadingState());
    (await getSearchChefsUseCase.execute(event.object)).fold(
        (l) => emit(VerifiedChefsErrorState(l)),
        (r) => emit(VerifiedChefsLoadedState(r)));
  }

  Future<FutureOr<void>> _onContinueSearching(
      ContinueSearchingChefs event, Emitter<VerifiedChefsState> emit) async {
    (await getSearchChefsUseCase.execute(event.object)).fold(
        (l) => emit(VerifiedChefsErrorState(l)),
        (r) => emit(VerifiedChefsLoadedState(r)));
  }

  FutureOr<void> _onUpdateFollow(
      UpdateFollowChef event, Emitter<VerifiedChefsState> emit) {
    emit(VerifiedChefsFollowSuccessState(event.object));
    GetIt.instance<BackgroundDataManager>()
        .updateFollow(event.object.chefId, event.object.option);
    updateUserFollowUseCase.execute(event.object);
  }

  Future<FutureOr<void>> _onGetChefsByIds(
      GetChefsByIds event, Emitter<VerifiedChefsState> emit) async {
    emit(VerifiedChefsLoadingState());
    (await getChefsByIdsUseCase.execute(event.ids)).fold(
        (l) => emit(VerifiedChefsErrorState(l)),
        (r) => emit(VerifiedChefsLoadedState(r)));
  }
}
