import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/domain/usecase/delete_notification_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_user_notification_usecase.dart';
import 'package:food_recipe_app/domain/usecase/update_is_read_by_offset_usecase.dart';
import 'package:meta/meta.dart';

part 'user_notification_event.dart';
part 'user_notification_state.dart';

class UserNotificationBloc
    extends Bloc<UserNotificationEvent, UserNotificationState> {
  GetUserNotificationUseCase getUserNotificationUseCase;
  DeleteNotificationUseCase deleteNotificationUseCase;
  UpdateIsReadByOffsetUseCase updateIsReadByOffsetUseCase;
  UserNotificationBloc(this.getUserNotificationUseCase,
      this.deleteNotificationUseCase, this.updateIsReadByOffsetUseCase)
      : super(UserNotificationInitial()) {
    on<LoadUserNotification>(_onLoadUserNotification);
    on<DeleteNotification>(_onDeleteNotification);
    on<UpdateNotificationStatus>(_onUpdateNotificationStatus);
  }

  Future<FutureOr<void>> _onLoadUserNotification(
      LoadUserNotification event, Emitter<UserNotificationState> emit) async {
    if (event.page == 0) emit(UserNotificationLoadingState());
    (await getUserNotificationUseCase.execute(event.page)).fold(
      (l) => emit(UserNotificationErrorState(l)),
      (r) => emit(UserNotificationLoadedState(r)),
    );
  }

  Future<FutureOr<void>> _onDeleteNotification(
      DeleteNotification event, Emitter<UserNotificationState> emit) async {
    emit(UserNotificationDeleteSuccess(event.notificationEntity));
    (await deleteNotificationUseCase.execute(event.notificationEntity.offSet))
        .fold((l) => emit(UserNotificationActionFailState(l)), (r) {});
  }

  Future<FutureOr<void>> _onUpdateNotificationStatus(
      UpdateNotificationStatus event,
      Emitter<UserNotificationState> emit) async {
    emit(UserNotificationUpdateSuccess(event.notificationEntity));
    (await updateIsReadByOffsetUseCase.execute(event.notificationEntity.offSet))
        .fold((l) => emit(UserNotificationActionFailState(l)), (r) {});
  }
}
