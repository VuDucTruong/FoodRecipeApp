

import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> loginWithGoogle(String loginId);
  Future<Either<Failure, UserEntity>> loginWithFacebook(String loginId);
  Future<Either<Failure, String>> refreshAccessToken();
  Future<Either<Failure, bool>> forgotPassword(String email);

  Future<Either<Failure, UserEntity>> register(String email, String password);
}