import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_ids_usecase.dart';
import 'package:meta/meta.dart';

import '../../../data/network/failure.dart';
import '../../../domain/entity/recipe_entity.dart';

part 'user_recipes_event.dart';
part 'user_recipes_state.dart';

class UserRecipesBloc extends Bloc<UserRecipesEvent, UserRecipesState> {
  GetRecipesFromIdsUseCase getRecipesFromIdsUseCase;

  UserRecipesBloc(this.getRecipesFromIdsUseCase) : super(UserRecipesInitial()) {
    on<LoadUserRecipesByIds>(_onLoadRecipes);
  }

  Future<FutureOr<void>> _onLoadRecipes(
      LoadUserRecipesByIds event, Emitter<UserRecipesState> emit) async {
    emit(UserRecipesLoadingState());
    (await getRecipesFromIdsUseCase.execute(event.idList)).fold(
      (l) => emit(UserRecipesErrorState(l)),
      (r) => emit(UserRecipesLoadedState(r)),
    );
  }
}
