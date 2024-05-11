import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetUserInfoUseCase implements BaseUseCase {
  final UserRepository _userRepository;

  GetUserInfoUseCase(this._userRepository);

  @override
  Future<Either<Failure, BackgroundUser>> execute(input) {
    return _userRepository.getUserInfo();
  }
}
