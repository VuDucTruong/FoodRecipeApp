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
    if (notificationList.isEmpty) {
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

class UserNotificationActionState extends UserNotificationState {}

class UserNotificationActionFailState extends UserNotificationActionState {
  Failure failure;

  UserNotificationActionFailState(this.failure);
}

class UserNotificationDeleteSuccess extends UserNotificationActionState {
  NotificationEntity notification;

  UserNotificationDeleteSuccess(this.notification);
}

class UserNotificationUpdateSuccess extends UserNotificationActionState {
  NotificationEntity notification;

  UserNotificationUpdateSuccess(this.notification);
}
