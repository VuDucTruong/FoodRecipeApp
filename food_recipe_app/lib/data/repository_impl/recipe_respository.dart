import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/data_source/recipe_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RecipeRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromLikes() async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API

        final response = await _remoteDataSource.getRecipesFromLikes();
        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.data.map((e) => e.toEntity()).toList());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        print(error);
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesByCategory(
      String category, int page) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getRecipesByCategory(category, page);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.data.map((e) => e.toEntity()).toList());
        } else {
          return Left(Failure(
              ApiInternalStatus.FAILURE, ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}
