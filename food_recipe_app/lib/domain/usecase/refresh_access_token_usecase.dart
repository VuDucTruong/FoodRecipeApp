

import 'package:dartz/dartz.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/respository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class RefreshAccessTokenUseCase implements BaseUseCase {
  final LoginRepository _loginRepository;

  RefreshAccessTokenUseCase(this._loginRepository);

  @override
  Future<Either<Failure, String>> execute(input) async {
    return await _loginRepository.refreshAccessToken();
  }
}
