import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/data_source/notification_remote_datasource.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  final NetworkInfo _networkInfo;

  NotificationRepositoryImpl(
      this.notificationRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getUserNotification(
      int page) async {
    if (await _networkInfo.isConnected) {
      try {
        return await notificationRemoteDataSource
            .getNotification(page)
            .then((response) {
          if (response.statusCode == ApiInternalStatus.SUCCESS) // success
          {
            return response.data == null
                ? Left(Failure.dataNotFound("Notifications"))
                : Right(response.data!.map((e) => e.toEntity()).toList());
          } else {
            return Left(Failure.internalServerError());
          }
        });
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(Failure.noInternet());
    }
  }
}
