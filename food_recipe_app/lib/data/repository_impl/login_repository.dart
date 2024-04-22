import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/background_data/device_info.dart';
import 'package:food_recipe_app/data/data_source/login_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/requests/login_request.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/respository/login_repository.dart';
import 'package:get_it/get_it.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginRemoteDataSource _loginRemoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  LoginRepositoryImpl(this._loginRemoteDataSource,
      this._networkInfo,this._appPreferences);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    if (await _networkInfo.isConnected){
      try {
        DeviceInfoParams deviceInfoParams = await GetIt.instance<DeviceInfo>().getDeviceInfo();
        final response = await _loginRemoteDataSource.login(
          LoginRequest(
            email: email,
            password: password,
            deviceInfo: deviceInfoParams.deviceInfo,
            deviceId: deviceInfoParams.deviceId,
            linkedAccountType: 'default')
        );
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
  Future<Either<Failure, UserEntity>> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> refreshAccessToken() async {
    if(await _networkInfo.isConnected){
      try {
        final token = await _appPreferences.getUserRefreshToken();
        if(token.isNotEmpty){
          final response = await _loginRemoteDataSource.refreshAccessToken();
          if(response.statusCode == 200){
            if(response.data==null)
            {
              return Left(Failure(0,'Data is null'));
            }
            assert(response.data != null);
            await _appPreferences.setUserToken(response.data!);
            }
          else if(response.statusCode == 401) {
              return Left(Failure(response.statusCode??0,
                  response.statusMessage??"expired refreshToken"));
          }
          return Left(Failure(response.statusCode??0,
              response.statusMessage??"null message"));
        } else {
          return Left(Failure(0,'Token is empty'));
        }
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    final response = await _loginRemoteDataSource.forgotPassword(email);
    if(response.statusCode == 200){
      if(response.data==null)
      {
        return Left(Failure(0,'Data is null'));
      }
      assert(response.data != null);
      return Right(response.data!);
    }
    else{
      return Left(Failure(response.statusCode??0,
          response.statusMessage??"null message"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithFacebook(String loginId) async {
    LoginRequest loginRequest = LoginRequest(
      loginId: loginId,
      linkedAccountType: 'facebook',
    );
    final response = await _loginRemoteDataSource.loginWithLoginId(loginRequest);
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
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle(String loginId) async {
    final response = await _loginRemoteDataSource.loginWithLoginId(
        LoginRequest(
          loginId: loginId,
          linkedAccountType: 'google',
        )
    );
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
  }

}