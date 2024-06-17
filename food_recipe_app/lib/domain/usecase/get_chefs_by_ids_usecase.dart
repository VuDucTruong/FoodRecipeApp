import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetChefsByIdsUseCase extends BaseUseCase<List<String>, List<ChefEntity>> {
  UserRepository userRepository;

  GetChefsByIdsUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<ChefEntity>>> execute(List<String> input) {
    return userRepository.getChefsByIds(input);
  }
}
