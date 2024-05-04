part of 'food_type_bloc.dart';

@immutable
sealed class FoodTypeState {}

final class FoodTypeInitial extends FoodTypeState {}

final class FoodTypeLoading extends FoodTypeState {}

final class FoodTypeSubmitSuccess extends FoodTypeState {

}
final class FoodTypeSubmitFailure extends FoodTypeState {
  final String errorMessage;
  FoodTypeSubmitFailure({required this.errorMessage});
}

