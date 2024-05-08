
import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class LoginVerifyUseCase implements BaseUseCase<String, bool> {
  final LoginRepository _loginRepository;

  LoginVerifyUseCase(this._loginRepository);

  @override
  Future<Either<Failure, bool>> execute(String email) async {
    return await _loginRepository.verifyLogin(email);
  }
}