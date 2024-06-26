import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/get_saved_recipes_object.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';
import 'package:food_recipe_app/domain/object/status_recipe_object.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/delete_user_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_my_recipes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_ids_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_saved_recipes_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_saved_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_user_recipe_usecase.dart';
import 'package:meta/meta.dart';

part 'saved_recipes_event.dart';
part 'saved_recipes_state.dart';

class SavedRecipesBloc extends Bloc<SavedRecipesEvent, SavedRecipesState> {
  GetSavedRecipesUseCase getSavedRecipesUseCase;
  UpdateSavedRecipeUseCase updateSavedRecipeUseCase;
  GetMyRecipesUseCase getMyRecipesUseCase;
  DeleteUserRecipeUseCase deleteUserRecipeUseCase;
  UpdateUserRecipeUseCase updateUserRecipeUseCase;

  SavedRecipesBloc(
      this.getSavedRecipesUseCase,
      this.updateSavedRecipeUseCase,
      this.getMyRecipesUseCase,
      this.deleteUserRecipeUseCase,
      this.updateUserRecipeUseCase)
      : super(SavedRecipesInitial()) {
    on<SavedRecipesCategorySelected>(_onSavedRecipesLoad);
    on<SavedRecipesContinueLoading>(_onSavedRecipesContinueLoading);
    on<LoadMyRecipes>(_onLoadMyRecipes);
    on<MyRecipesContinueLoading>(_onMyRecipesContinueLoading);
    on<DeleteUserRecipe>(_onDeleteRecipe);
    on<UpdateUserRecipe>(_onUpdateUserRecipe);
  }

  Future<FutureOr<void>> _onSavedRecipesLoad(SavedRecipesCategorySelected event,
      Emitter<SavedRecipesState> emit) async {
    emit(SavedRecipesLoadingState());
    (await getSavedRecipesUseCase.execute(event.object)).fold(
        (l) => emit(SavedRecipesErrorState(l)),
        (r) => emit(SavedRecipesLoadedState(r)));
  }

  Future<FutureOr<void>> _onSavedRecipesContinueLoading(
      SavedRecipesContinueLoading event,
      Emitter<SavedRecipesState> emit) async {
    (await getSavedRecipesUseCase.execute(event.object)).fold(
        (l) => emit(SavedRecipesErrorState(l)),
        (r) => emit(SavedRecipesLoadedState(r)));
  }

  Future<FutureOr<void>> _onLoadMyRecipes(
      LoadMyRecipes event, Emitter<SavedRecipesState> emit) async {
    emit(SavedRecipesLoadingState());
    (await getMyRecipesUseCase.execute(event.object)).fold(
        (l) => emit(SavedRecipesErrorState(l)),
        (r) => emit(SavedRecipesLoadedState(r)));
  }

  Future<FutureOr<void>> _onMyRecipesContinueLoading(
      MyRecipesContinueLoading event, Emitter<SavedRecipesState> emit) async {
    (await getMyRecipesUseCase.execute(event.object)).fold(
        (l) => emit(SavedRecipesErrorState(l)),
        (r) => emit(SavedRecipesLoadedState(r)));
  }

  Future<FutureOr<void>> _onDeleteRecipe(
      DeleteUserRecipe event, Emitter<SavedRecipesState> emit) async {
    emit(SavedRecipesDeletedState(event.recipeEntity));
    (deleteUserRecipeUseCase.execute(event.recipeEntity.id));
  }

  FutureOr<void> _onUpdateUserRecipe(
      UpdateUserRecipe event, Emitter<SavedRecipesState> emit) {}
}
