import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class GoogleLoginUseCase
    implements BaseUseCase<GoogleLoginUseCaseInput, UserEntity> {
  final LoginRepository _loginRepository;
  GoogleLoginUseCase(this._loginRepository);

  @override
  Future<Either<Failure, UserEntity>> execute(GoogleLoginUseCaseInput params) {
    return _loginRepository.loginWithGoogle(params.loginId);
  }
}

class GoogleLoginUseCaseInput {
  final String loginId;

  GoogleLoginUseCaseInput({
    required this.loginId,
  });
}
