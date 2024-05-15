import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetChefInfoByIdUseCase extends BaseUseCase<String, ChefEntity> {
  UserRepository _userRepository;

  GetChefInfoByIdUseCase(this._userRepository);

  @override
  Future<Either<Failure, ChefEntity>> execute(String input) async {
    return await _userRepository.getChefInfo(input);
  }
}
