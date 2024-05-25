
import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateUserPasswordUseCase extends BaseUseCase<String, bool> {
  final UserRepository userRepository;
  UpdateUserPasswordUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> execute(String input) {
    return userRepository.updatePassword(input);
  }
}

