import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, UserEntity> {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<Either<Failure, UserEntity>> execute(LoginUseCaseInput params) async {
    return await _loginRepository.login(params.email, params.password);
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
