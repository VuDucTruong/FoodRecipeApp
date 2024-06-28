import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/update_follow_object.dart';
import 'package:food_recipe_app/domain/usecase/get_chef_info_by_id_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_from_ids_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_user_follow_usecase.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'chef_info_event.dart';
part 'chef_info_state.dart';

class ChefInfoBloc extends Bloc<ChefInfoEvent, ChefInfoState> {
  GetChefInfoByIdUseCase getChefInfoByIdUseCase;
  GetRecipesFromIdsUseCase getRecipesFromIdsUseCase;
  UpdateUserFollowUseCase updateUserFollowUseCase;
  ChefInfoBloc(this.getChefInfoByIdUseCase, this.getRecipesFromIdsUseCase,
      this.updateUserFollowUseCase)
      : super(ChefInfoInitial()) {
    on<LoadChefInfoById>(_onLoadById);
    on<LoadChefRecipes>(_onLoadRecipes);
    on<UpdateFollowChef>(_onUpdateFollow);
  }

  Future<FutureOr<void>> _onLoadById(
      LoadChefInfoById event, Emitter<ChefInfoState> emit) async {
    emit(ChefInfoLoadingState());
    (await getChefInfoByIdUseCase.execute(event.id)).fold(
        (l) => emit(ChefInfoErrorState(l)),
        (r) => emit(ChefInfoLoadedState(r)));
  }

  Future<FutureOr<void>> _onLoadRecipes(
      LoadChefRecipes event, Emitter<ChefInfoState> emit) async {
    emit(ChefRecipeLoadingState());
    (await getRecipesFromIdsUseCase.execute(event.recipeIdList)).fold(
        (l) => emit(ChefRecipeErrorState(l)),
        (r) => emit(ChefRecipeLoadedState(r)));
  }

  FutureOr<void> _onUpdateFollow(
      UpdateFollowChef event, Emitter<ChefInfoState> emit) {
    GetIt.instance<BackgroundDataManager>()
        .updateFollow(event.object.chefId, event.object.option);
    emit(ChefInfoLoadedState(event.chefEntity));
    updateUserFollowUseCase.execute(event.object);
  }
}
