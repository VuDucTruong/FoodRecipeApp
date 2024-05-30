import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_recipe_event.dart';
part 'detail_recipe_state.dart';

class DetailRecipeBloc extends Bloc<DetailRecipeEvent, DetailRecipeState> {
  DetailRecipeBloc() : super(DetailRecipeInitial()) {
    on<UpdateLikeStatus>(_onUpdateLike);
    on<UpdateSaveStatus>(_onUpdateSave);
  }

  FutureOr<void> _onUpdateLike(
      UpdateLikeStatus event, Emitter<DetailRecipeState> emit) {}

  FutureOr<void> _onUpdateSave(
      UpdateSaveStatus event, Emitter<DetailRecipeState> emit) {}
}
