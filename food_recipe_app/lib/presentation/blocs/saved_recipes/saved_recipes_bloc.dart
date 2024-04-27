import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_saved_recipes_usecase.dart';
import 'package:food_recipe_app/presentation/common/helper/get_saved_recipes_object.dart';
import 'package:meta/meta.dart';

part 'saved_recipes_event.dart';
part 'saved_recipes_state.dart';

class SavedRecipesBloc extends Bloc<SavedRecipesEvent, SavedRecipesState> {
  GetSavedRecipesUseCase getSavedRecipesUseCase;

  SavedRecipesBloc(this.getSavedRecipesUseCase) : super(SavedRecipesInitial()) {
    on<SavedRecipesCategorySelected>(_onSavedRecipesLoad);
    on<SavedRecipesConinueLoading>(_onSavedRecipesContinueLoading);
    on<UnSaveRecipe>(_onUnSavedRecipe);
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

  FutureOr<void> _onUnSavedRecipe(
      UnSaveRecipe event, Emitter<SavedRecipesState> emit) {}
}
