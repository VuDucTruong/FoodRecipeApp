import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_food_event.dart';
part 'detail_food_state.dart';

class DetailFoodBloc extends Bloc<DetailFoodEvent, DetailFoodState> {
  DetailFoodBloc() : super(DetailFoodInitial()) {
    on<DetailFoodEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
