import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/user_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  UserRepositoryImpl(
      this.userRemoteDataSource, this._networkInfo, this._appPreferences);

  @override
  Future<Either<Failure, BackgroundUser>> getUserInfo() async {
    debugPrint('getUserInfo');
    if (await _networkInfo.isConnected) {
      try {
        final response = await userRemoteDataSource.getUserInfo();
        if (response.statusCode == ResponseCode.SUCCESS) {
          if (response.data == null) {
            return Left(Failure.dataNotExisted('User'));
          }
          assert(response.data != null);
          return Right(response.data!.toBackgroundUser());
        }
        else {
          return Left(Failure.internalServerError());
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<ChefEntity>>> getVerifiedChefs() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await userRemoteDataSource.getVerifiedChefs();
        if (response.status == ResponseCode.SUCCESS) {
          return Right(response.data.map((e) => e.toEntity()).toList());
        } else {
          return Left(Failure.dataNotExisted("Chef"));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(Failure.noInternet());
    }
  }
}
