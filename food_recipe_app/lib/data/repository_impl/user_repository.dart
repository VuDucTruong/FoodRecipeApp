import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/user_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  UserRepositoryImpl(
      this.userRemoteDataSource, this._networkInfo, this._appPreferences);

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async {
    debugPrint('getUserInfo');
    if (await _networkInfo.isConnected) {
      try {
        final response = await userRemoteDataSource.getUserInfo();
        if (response.statusCode == 200) {
          if (response.data == null) {
            return Left(Failure(0, 'Data is null'));
          }
          debugPrint('getUserInfo: ${response.data}');
          assert(response.data != null);
          return Right(response.data!.toEntity());
        } else {
          return Left(Failure(response.statusCode ?? 0,
              response.statusMessage ?? "null message"));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
