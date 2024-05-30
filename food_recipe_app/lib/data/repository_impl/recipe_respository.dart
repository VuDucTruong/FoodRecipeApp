import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/data/data_source/recipe_remote_data_source.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/data/network/network_info.dart';
import 'package:food_recipe_app/data/requests/create_recipe_request.dart';
import 'package:food_recipe_app/data/requests/get_recipes_search_request.dart';
import 'package:food_recipe_app/data/requests/recipe_update_request.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/recipe_respository.dart';
import 'package:food_recipe_app/domain/object/create_recipe_object.dart';

import '../background_data/background_data_manager.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource _recipeDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;
  final BackgroundDataManager _backgroundDataManager;

  RecipeRepositoryImpl(this._recipeDataSource, this._networkInfo,
      this._appPreferences, this._backgroundDataManager);

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromLikes() async {
    if (await _networkInfo.isConnected) {
      try {
        return await _recipeDataSource.getRecipesFromLikes().then((response) {
          if (response.statusCode == ApiInternalStatus.SUCCESS) // success
          {
            return response.data == null
                ? Left(Failure.dataNotFound("Recipes"))
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

  @override
  Future<Either<Failure, RecipeEntity>> createRecipe(
      CreateRecipeObject object) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _recipeDataSource
            .createRecipe(CreateRecipeRequest.fromObject(object));
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          if (response.data != null) {
            final recipeEntity = response.data!.toEntity();
            /*BackgroundUser user = BackgroundUser.decode(await _appPreferences.getBackgroundUser());
              user.recipeIds.add(recipeEntity.id);
              await _appPreferences.setBackgroundUser(user.toString());*/
            return Right(recipeEntity);
          }
          return Left(Failure.internalServerError());
        } else {
          return Left(Failure(
              ApiInternalStatus.FAILURE, ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getSavedRecipesSearch(
      GetRecipesSearchRequestDto request) async {
    if (await _networkInfo.isConnected) {
      try {
        GetRecipesSearchRequest searchRequest =
            GetRecipesSearchRequest.fromGetRecipesSearchRequestDto(request);
        final response =
            await _recipeDataSource.getSavedRecipesSearch(searchRequest);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          return response.data != null
              ? Right(response.data!.map((e) => e.toEntity()).toList())
              : Left(Failure.dataNotFound("Recipes"));
        } else {
          return Left(Failure(
              ApiInternalStatus.FAILURE, ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(Failure.noInternet());
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getLikedRecipesSearch(
      GetRecipesSearchRequestDto request) async {
    if (await _networkInfo.isConnected) {
      try {
        GetRecipesSearchRequest searchRequest =
            GetRecipesSearchRequest.fromGetRecipesSearchRequestDto(request);
        final response =
            await _recipeDataSource.getLikedRecipesSearch(searchRequest);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          return response.data != null
              ? Right(response.data!.map((e) => e.toEntity()).toList())
              : Left(Failure.dataNotFound("Recipes"));
        } else {
          return Left(Failure(
              ApiInternalStatus.FAILURE, ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromIds(
      List<String> ids) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _recipeDataSource.getRecipesFromIds(ids);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          return response.data != null
              ? Right(response.data!.map((e) => e.toEntity()).toList())
              : Left(Failure.dataNotFound("Recipes"));
        } else {
          return Left(Failure(
              ApiInternalStatus.FAILURE, ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesSearch(
      GetRecipesSearchRequestDto request) async {
    if (await _networkInfo.isConnected) {
      try {
        GetRecipesSearchRequest searchRequest =
            GetRecipesSearchRequest.fromGetRecipesSearchRequestDto(request);
        final response =
            await _recipeDataSource.getRecipesSearch(searchRequest);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          return response.data != null
              ? Right(response.data!.map((e) => e.toEntity()).toList())
              : Left(Failure.dataNotFound("Recipes"));
        } else {
          return Left(Failure(
              ApiInternalStatus.FAILURE, ResponseMessage.CONNECTION_ERROR));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, void>> updateLikeRecipe(
      String recipeId, bool option) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _recipeDataSource.updateLikeRecipe(recipeId, option);

        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          _backgroundDataManager.updateLikeRecipe(recipeId, option);
          return const Right(null);
        } else {
          return Left(Failure.internalServerError());
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, bool>> updateRecipe(
      UpdateRecipeRequestDto request) async {
    if (await _networkInfo.isConnected) {
      try {
        final updateRequest =
            RecipeUpdateRequest.fromRecipeUpdateRequestDto(request);
        final response = await _recipeDataSource.updateRecipe(updateRequest);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          return response.data != null
              ? Right(response.data!)
              : Left(Failure.actionFailed("Update Recipe"));
        } else {
          return Left(Failure.internalServerError());
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, void>> updateSaveRecipe(
      String recipeId, bool option) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _recipeDataSource.updateSaveRecipe(recipeId, option);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          _backgroundDataManager.updateSavedRecipe(recipeId, option);
          return const Right(null);
        } else {
          return Left(Failure.internalServerError());
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRecipe(String recipeId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _recipeDataSource.deleteRecipe(recipeId);
        if (response.statusCode == ApiInternalStatus.SUCCESS) {
          if (response.data != null) {
            _backgroundDataManager.deleteSelfRecipe(recipeId);
            return Right(response.data!);
          }
          return Left(Failure.actionFailed("Delete Recipe"));
        } else {
          return Left(Failure.internalServerError());
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(Failure.noInternet());
    }
  }
}
