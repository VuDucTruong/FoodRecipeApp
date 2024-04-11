import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_likes_usecase.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetRecipesFromLikesUseCase getRecipesFromLikesUseCase;

  HomeBloc({required this.getRecipesFromLikesUseCase}) : super(HomeInitial()) {
    on<HomeInitialEvent>(_homeInitialEvent);
  }

  FutureOr<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    (await getRecipesFromLikesUseCase.execute(null)).fold(
        (l) => emit(HomeErrorState(failure: l)),
        (r) => emit(HomeLoadingSuccessState(r)));
  }
}
