import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/user_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';

import 'package:food_recipe_app/data/requests/user_search_request.dart';
import 'package:food_recipe_app/data/requests/user_update_request.dart';

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
        final response = await userRemoteDataSource.getSelfInfo();
        if (response.statusCode == ResponseCode.SUCCESS) {
          if (response.data == null) {
            return Left(Failure.dataNotFound('Profile information'));
          }
          return Right(response.data!.toBackgroundUser());
        } else {
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
        if (response.statusCode == ResponseCode.SUCCESS) {
          if (response.data == null) {
            return Left(Failure.dataNotFound("Chefs"));
          }
          return Right(response.data!.map((e) => e.toEntity()).toList());
        } else {
          return Left(Failure.dataNotFound("Chef"));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, ChefEntity>> getChefInfo(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await userRemoteDataSource.getChefInfo(id);
        if (response.statusCode == 200) {
          return Right(response.data!.toEntity());
        } else {
          return Left(Failure(response.statusCode ?? ResponseCode.DEFAULT,
              response.statusMessage ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProfile() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await userRemoteDataSource.deleteProfile();
        if (response.statusCode == ResponseCode.SUCCESS) {
          return response.data != null
              ? const Right(true)
              : Left(Failure.actionFailed("Delete profile"));
        } else {
          return Left(Failure.internalServerError());
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ChefEntity>> getProfileById(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        return await userRemoteDataSource.getProfileById(id).then((response) {
          if (response.statusCode == ResponseCode.SUCCESS) {
            if (response.data == null) {
              return Left(Failure.dataNotFound("Chef"));
            }
            return Right(response.data!.toEntity());
          } else {
            return Left(Failure.internalServerError());
          }
        });
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<ChefEntity>>> getProfileSearch(
      UserSearchRequestDto request) async {
    if (await _networkInfo.isConnected) {
      try {
        UserSearchRequest searchRequest =
            UserSearchRequest.fromUserSearchRequestDto(request);
        return await userRemoteDataSource
            .getProfileSearch(searchRequest)
            .then((response) {
          if (response.statusCode == ResponseCode.SUCCESS) {
            return response.data != null
                ? Right(response.data!.map((e) => e.toEntity()).toList())
                : Left(Failure.dataNotFound("Chefs"));
          } else {
            return Left(Failure.internalServerError());
          }
        });
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, bool>> updateFollow(
      String targetChefId, bool option) async {
    if (await _networkInfo.isConnected) {
      try {
        return await userRemoteDataSource
            .updateFollow(targetChefId, option)
            .then((response) {
          if (response.statusCode == ResponseCode.SUCCESS) {
            return response.data != null
                ? const Right(true)
                : Left(Failure.actionFailed("Follow user"));
          } else {
            return Left(Failure.internalServerError());
          }
        });
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword(String password) async {
    if (await _networkInfo.isConnected) {
      try {
        return await userRemoteDataSource
            .updatePassword(password)
            .then((response) {
          if (response.statusCode == ResponseCode.SUCCESS) {
            return response.data != null
                ? const Right(true)
                : Left(Failure.actionFailed("Update password"));
          } else {
            return Left(Failure.internalServerError());
          }
        });
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, ProfileInformation>> updateProfile(
      UserUpdateRequestDto request) async {
    if (await _networkInfo.isConnected) {
      try {
        UserUpdateRequest updateRequest =
            UserUpdateRequest.fromUserUpdateRequestDto(request);
        return await userRemoteDataSource
            .updateProfile(updateRequest)
            .then((response) {
          if (response.statusCode == ResponseCode.SUCCESS) {
            return response.data != null
                ? Right(response.data!.toProfileInformation())
                : Left(Failure.actionFailed("Update profile"));
          } else {
            return Left(Failure.internalServerError());
          }
        });
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }
}
