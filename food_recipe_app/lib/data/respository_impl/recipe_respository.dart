import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/data_source/recipe_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/responses/recipe_response.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/respository/recipe_respository.dart';

class RecipeRespositoryImpl implements RecipeRespository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RecipeRespositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromLikes() async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API

        final response = await _remoteDataSource.getRecipesFromLikes();
        /*if (response.status == ApiInternalStatus.SUCCESS) // success
            {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }*/
        return Right(response.map((e) => e.toDomain()).toList());
      } catch (error) {
        print(error);
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
