part of 'main_view_bloc.dart';

@immutable
sealed class MainViewState {}

final class MainViewInitialEvent extends MainViewState {}

final class MainViewLoadingEvent extends MainViewState {}

final class MainViewErrorEvent extends MainViewState {
  final Failure failure;

  MainViewErrorEvent(this.failure);
}

final class MainViewSuccessEvent extends MainViewState {
  final UserEntity user;

  MainViewSuccessEvent(this.user);
}
