import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/get_saved_recipes_object.dart';
import 'package:food_recipe_app/domain/object/status_recipe_object.dart';
import 'package:food_recipe_app/domain/usecase/get_saved_recipes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_saved_recipe_usecase.dart';
import 'package:meta/meta.dart';

part 'saved_recipes_event.dart';
part 'saved_recipes_state.dart';

class SavedRecipesBloc extends Bloc<SavedRecipesEvent, SavedRecipesState> {
  GetSavedRecipesUseCase getSavedRecipesUseCase;
  UpdateSavedRecipeUseCase updateSavedRecipeUseCase;

  SavedRecipesBloc(this.getSavedRecipesUseCase, this.updateSavedRecipeUseCase)
      : super(SavedRecipesInitial()) {
    on<SavedRecipesCategorySelected>(_onSavedRecipesLoad);
    on<SavedRecipesConinueLoading>(_onSavedRecipesContinueLoading);
  }

  Future<FutureOr<void>> _onSavedRecipesLoad(SavedRecipesCategorySelected event,
      Emitter<SavedRecipesState> emit) async {
    emit(SavedRecipesLoadingState());
    (await getSavedRecipesUseCase.execute(event.getSavedRecipesObject)).fold(
        (l) => emit(SavedRecipesErrorState(l)),
        (r) => emit(SavedRecipesLoadedState(r)));
  }

  Future<FutureOr<void>> _onSavedRecipesContinueLoading(
      SavedRecipesConinueLoading event, Emitter<SavedRecipesState> emit) async {
    (await getSavedRecipesUseCase.execute(event.getSavedRecipesObject)).fold(
        (l) => emit(SavedRecipesErrorState(l)),
        (r) => emit(SavedRecipesLoadedState(r)));
  }
}
