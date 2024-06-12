import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/domain/usecase/get_user_notification_usecase.dart';
import 'package:meta/meta.dart';

part 'user_notification_event.dart';
part 'user_notification_state.dart';

class UserNotificationBloc
    extends Bloc<UserNotificationEvent, UserNotificationState> {
  GetUserNotificationUseCase getUserNotificationUseCase;

  UserNotificationBloc(this.getUserNotificationUseCase)
      : super(UserNotificationInitial()) {
    on<LoadUserNotification>(_onLoadUserNotification);
  }

  Future<FutureOr<void>> _onLoadUserNotification(
      LoadUserNotification event, Emitter<UserNotificationState> emit) async {
    emit(UserNotificationLoadingState());
    (await getUserNotificationUseCase.execute(event.page)).fold(
      (l) => emit(UserNotificationErrorState(l)),
      (r) => emit(UserNotificationLoadedState(r)),
    );
  }
}
