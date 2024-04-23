import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetChefsFromRankUseCase extends BaseUseCase<void, List<ChefEntity>> {
  final UserRepository _userRepository;

  GetChefsFromRankUseCase(this._userRepository);

  @override
  Future<Either<Failure, List<ChefEntity>>> execute(void input) async {
    return await _userRepository.getVerifiedChefs();
  }
}
