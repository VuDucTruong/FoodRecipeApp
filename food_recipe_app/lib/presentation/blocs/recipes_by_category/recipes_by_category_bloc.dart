import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/get_recipes_by_category_object.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_by_category_usecase.dart';
import 'package:meta/meta.dart';

part 'recipes_by_category_event.dart';
part 'recipes_by_category_state.dart';

class RecipesByCategoryBloc
    extends Bloc<RecipesByCategoryEvent, RecipesByCategoryState> {
  GetRecipesByCategoryUseCase getRecipesByCategory;

  RecipesByCategoryBloc(this.getRecipesByCategory)
      : super(RecipesByCategoryInitial()) {
    on<CategorySelected>(_onCategorySelected);
    on<ConinueLoadingRecipes>(_onContinueLoading);
  }

  Future<FutureOr<void>> _onCategorySelected(
      CategorySelected event, Emitter<RecipesByCategoryState> emit) async {
    emit(RecipesByCategoryLoadingState());
    (await getRecipesByCategory.execute(event.object)).fold(
        (l) => emit(RecipesByCategoryErrorState(l)),
        (r) => emit(RecipesByCategoryLoadedState(r)));
  }

  Future<FutureOr<void>> _onContinueLoading(
      ConinueLoadingRecipes event, Emitter<RecipesByCategoryState> emit) async {
    (await getRecipesByCategory.execute(event.object)).fold(
        (l) => emit(RecipesByCategoryErrorState(l)),
        (r) => emit(RecipesByCategoryLoadedState(r)));
  }
}
