part of 'user_notification_bloc.dart';

@immutable
sealed class UserNotificationState {
  bool isLastPage = false;
}

final class UserNotificationInitial extends UserNotificationState {}

class UserNotificationLoadingState extends UserNotificationState {}

class UserNotificationLoadedState extends UserNotificationState {
  List<NotificationEntity> notificationList;

  UserNotificationLoadedState(this.notificationList) {
    if (notificationList.length < 10) {
      isLastPage = true;
    }
  }
}

class UserNotificationErrorState extends UserNotificationState {
  Failure failure;

  UserNotificationErrorState(this.failure) {
    isLastPage = true;
  }
}
