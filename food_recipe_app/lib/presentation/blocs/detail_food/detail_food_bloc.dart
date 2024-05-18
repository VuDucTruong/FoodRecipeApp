import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_food_event.dart';
part 'detail_food_state.dart';

class DetailFoodBloc extends Bloc<DetailFoodEvent, DetailFoodState> {


  DetailFoodBloc() : super(DetailFoodInitial()) {
    on<LikeRecipe>(_onLikeRecipe);
    on<SaveRecipe>(_onSaveRecipe);
  }

  FutureOr<void> _onLikeRecipe(LikeRecipe event, Emitter<DetailFoodState> emit) {

  }

  FutureOr<void> _onSaveRecipe(SaveRecipe event, Emitter<DetailFoodState> emit) {
  }
}
