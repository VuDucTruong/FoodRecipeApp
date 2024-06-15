import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/notification_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateIsReadByOffsetUseCase extends BaseUseCase<int, void> {
  NotificationRepository notificationRepository;

  UpdateIsReadByOffsetUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, void>> execute(int input) {
    return notificationRepository.updateIsReadByOffset(input);
  }
}
