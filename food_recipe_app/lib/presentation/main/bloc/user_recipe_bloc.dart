import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_recipe_event.dart';
part 'user_recipe_state.dart';

class UserRecipeBloc extends Bloc<UserRecipeEvent, UserRecipeState> {




  UserRecipeBloc() : super(UserRecipeInitial()) {
    on<UserRecipeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
