

import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

abstract class UserRepository{
  Future<Either<Failure,UserEntity>> getUserInfo();
}