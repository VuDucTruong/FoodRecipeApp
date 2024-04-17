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
    debugPrint('login repository: say hallo');
    if (await _networkInfo.isConnected){
      try {
        final response = await _loginRemoteDataSource.login(email, password);
        debugPrint('login repository: ${response.data.toString()}');
        if(response.statusCode == 200){
          if(response.data==null)
            {
              return Left(Failure(0,'Data is null'));
            }
          assert(response.data != null);
          await _appPreferences.setUserToken(response.data!.accessToken);
          await _appPreferences.setUserRefreshToken(response.data!.refreshToken);
          return Right(response.data!.user.toEntity());
        }
        else{
          return Left(Failure(response.statusCode??0,
              response.statusMessage??"null message"));
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