import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateUserProfileUsecase extends BaseUseCase<ProfileInformation , bool> {
  @override
  Future<Either<Failure, bool>> execute(ProfileInformation input) {
    // TODO: implement execute
    throw UnimplementedError();
  }

}