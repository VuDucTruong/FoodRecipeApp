import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/notification_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class DeleteNotificationUseCase extends BaseUseCase<int, void> {
  NotificationRepository notificationRepository;

  DeleteNotificationUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, void>> execute(int input) {
    return notificationRepository.deleteNotificationByOffset(input);
  }
}
