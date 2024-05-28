

import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class DeleteUserProfileUseCase extends BaseUseCase<void, bool>{
  final UserRepository _userRepository;

  DeleteUserProfileUseCase(this._userRepository);

  @override
  Future<Either<Failure, bool>> execute(void input) {
    return _userRepository.deleteProfile();
  }

}