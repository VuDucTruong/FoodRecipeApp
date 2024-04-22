import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_by_category.dart';
import 'package:meta/meta.dart';

part 'recipes_by_category_event.dart';
part 'recipes_by_category_state.dart';

class RecipesByCategoryBloc
    extends Bloc<RecipesByCategoryEvent, RecipesByCategoryState> {
  GetRecipesByCategory getRecipesByCategory;

  RecipesByCategoryBloc(this.getRecipesByCategory)
      : super(RecipesByCategoryInitial()) {
    on<CategorySelected>(_onCategorySelected);
  }

  Future<FutureOr<void>> _onCategorySelected(
      CategorySelected event, Emitter<RecipesByCategoryState> emit) async {
    emit(RecipesByCategoryLoadingState());
    (await getRecipesByCategory
            .execute(GetRecipesByCategoryInput(category: event.category)))
        .fold((l) => emit(RecipesByCategoryErrorState(l)),
            (r) => emit(RecipesByCategoryLoadedState(r)));
  }
}
