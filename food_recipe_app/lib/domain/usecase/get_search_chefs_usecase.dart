import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/object/user_search_object.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GetSearchChefsUseCase extends BaseUseCase<UserSearchObject  , List<ChefEntity>> {
  UserRepository userRepository;

  GetSearchChefsUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<ChefEntity>>> execute(UserSearchObject input) {
    return userRepository.getSearchChefs(input);
  }




}