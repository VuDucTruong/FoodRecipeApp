import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/login_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/respository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginRemoteDataSource _loginRemoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  LoginRepositoryImpl(this._loginRemoteDataSource,
      this._networkInfo,this._appPreferences);


  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    // if (await _networkInfo.isConnected){
    //   try {
    //     final response = await _loginRemoteDataSource.getUser();
    //     return Right(response.map((e) => e.toDomain()).toList());
    //   } catch (error) {
    //     print(error);
    //     return (Left(ErrorHandler.handle(error).failure));
    //   }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    if (await _networkInfo.isConnected){
      try {
        final response = await _loginRemoteDataSource.login(email, password);
        if(response.status==ApiInternalStatus.SUCCESS)
          {
            await _appPreferences.setUserRefreshToken(response.refreshToken);
            await _appPreferences.setUserToken(response.accessToken);
            return Right(response.user.toEntity());
          }
        else
          {
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
      } catch (error) {
        debugPrint(error.toString());
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}