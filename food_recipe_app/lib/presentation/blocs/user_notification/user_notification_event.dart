part of 'user_notification_bloc.dart';

@immutable
sealed class UserNotificationEvent {}

class LoadUserNotification extends UserNotificationEvent {
  int page = 0;

  LoadUserNotification(this.page);
}

class UpdateNotificationStatus extends UserNotificationEvent {
  NotificationEntity notificationEntity;

  UpdateNotificationStatus(this.notificationEntity);
}

class DeleteNotification extends UserNotificationEvent {
  NotificationEntity notificationEntity;

  DeleteNotification(this.notificationEntity);
}
