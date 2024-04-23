import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_likes_usecase.dart';
import 'package:meta/meta.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  GetRecipesFromLikesUseCase getRecipesFromLikesUseCase;

  TrendingBloc(this.getRecipesFromLikesUseCase) : super(TrendingInitial()) {
    on<TrendingLoad>(_onTrendingLoad);
  }

  Future<FutureOr<void>> _onTrendingLoad(
      TrendingLoad event, Emitter<TrendingState> emit) async {
    emit(TrendingLoadingState());
    (await getRecipesFromLikesUseCase.execute(null)).fold(
        (l) => emit(TrendingErrorState(l)),
        (r) => emit(TrendingLoadedState(r)));
  }
}
