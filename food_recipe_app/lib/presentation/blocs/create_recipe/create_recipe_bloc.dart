import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/usecase/create_recipe_usecase.dart';
import 'package:food_recipe_app/domain/object/create_recipe_object.dart';
import 'package:meta/meta.dart';

part 'create_recipe_event.dart';
part 'create_recipe_state.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  CreateRecipeUseCase createRecipeUseCase;

  CreateRecipeBloc(this.createRecipeUseCase) : super(CreateRecipeInitial()) {
    on<CreateRecipeButtonPressed>(_onCreateRecipeButtonPressed);
  }

  Future<FutureOr<void>> _onCreateRecipeButtonPressed(
      CreateRecipeButtonPressed event, Emitter<CreateRecipeState> emit) async {
    emit(CreateRecipeLoadingState());
    (await createRecipeUseCase.execute(event.object)).fold(
        (l) => emit(CreateRecipeErrorState(l)),
        (r) => emit(CreateRecipeSuccessState(r)));
  }
}
