import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getUserNotification(
      int page);

  Future<Either<Failure, void>> deleteNotificationByOffset(int offset);
  Future<Either<Failure, void>> updateIsReadByOffset(int offset);
}
