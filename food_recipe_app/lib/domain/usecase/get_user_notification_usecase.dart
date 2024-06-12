import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/domain/repository/notification_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetUserNotificationUseCase
    extends BaseUseCase<int, List<NotificationEntity>> {
  NotificationRepository notificationRepository;

  GetUserNotificationUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> execute(int input) {
    return notificationRepository.getUserNotification(input);
  }
}
