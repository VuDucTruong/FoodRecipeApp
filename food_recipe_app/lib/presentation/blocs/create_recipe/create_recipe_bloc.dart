import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_recipe_event.dart';
part 'create_recipe_state.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  CreateRecipeBloc() : super(CreateRecipeInitial()) {
    on<CreateRecipeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
