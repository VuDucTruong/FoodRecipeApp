import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class FacebookLoginUseCase
    implements BaseUseCase<FacebookLoginUseCaseInput, UserEntity> {
  final LoginRepository _loginRepository;
  FacebookLoginUseCase(this._loginRepository);

  @override
  Future<Either<Failure, UserEntity>> execute(
      FacebookLoginUseCaseInput params) {
    return _loginRepository.loginWithFacebook(params.loginId);
  }
}

class FacebookLoginUseCaseInput {
  final String loginId;

  FacebookLoginUseCaseInput({
    required this.loginId,
  });
}
