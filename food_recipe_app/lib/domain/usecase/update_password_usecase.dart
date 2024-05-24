import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdatePasswordUseCase extends BaseUseCase<String , bool> {
  UserRepository userRepository;


  UpdatePasswordUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> execute(String input) {
    return userRepository.updatePassword(input);
  }

}