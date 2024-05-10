import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, BackgroundUser>> getUserInfo();
  Future<Either<Failure, List<ChefEntity>>> getVerifiedChefs();
}
