import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/object/update_follow_object.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateUserFollowUseCase extends BaseUseCase<UpdateFollowObject, void> {
  UserRepository userRepository;

  UpdateUserFollowUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> execute(UpdateFollowObject input) {
    return userRepository.updateFollow(input);
  }
}
