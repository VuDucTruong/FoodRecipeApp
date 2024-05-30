import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/object/status_recipe_object.dart';
import 'package:food_recipe_app/domain/usecase/update_like_recipe_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_saved_recipe_usecase.dart';
import 'package:meta/meta.dart';

part 'detail_recipe_event.dart';
part 'detail_recipe_state.dart';

class DetailRecipeBloc extends Bloc<DetailRecipeEvent, DetailRecipeState> {
  UpdateLikeRecipeUseCase updateLikeRecipeUseCase;
  UpdateSavedRecipeUseCase updateSavedRecipeUseCase;

  DetailRecipeBloc(this.updateLikeRecipeUseCase, this.updateSavedRecipeUseCase)
      : super(DetailRecipeInitial()) {
    on<UpdateLikeStatus>(_onUpdateLike);
    on<UpdateSaveStatus>(_onUpdateSave);
  }

  Future<FutureOr<void>> _onUpdateLike(
      UpdateLikeStatus event, Emitter<DetailRecipeState> emit) async {
    (await updateLikeRecipeUseCase.execute(event.object)).fold(
      (l) {
        emit(RecipeLikeFailState(l));
      },
      (r) {
        emit(RecipeLikeSuccessState(event.object.option));
      },
    );
  }

  Future<FutureOr<void>> _onUpdateSave(
      UpdateSaveStatus event, Emitter<DetailRecipeState> emit) async {
    (await updateSavedRecipeUseCase.execute(event.object)).fold(
      (l) => emit(RecipeSaveFailState(l)),
      (r) {
        emit(RecipeSaveSuccessState(event.object.option));
      },
    );
  }
}
