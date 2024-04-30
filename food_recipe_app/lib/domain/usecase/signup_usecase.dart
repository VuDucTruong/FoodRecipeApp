
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class SignupWithEmailUseCase implements BaseUseCase<SignupUseCaseInput, void> {
  final LoginRepository _loginRepository;

  SignupWithEmailUseCase(this._loginRepository);

  @override
  Future<Either<Failure, void>> execute(SignupUseCaseInput params) async {
    return await _loginRepository.registerWithEmail(
        RegisterWithEmailRepositoryDTO(
            email: params.email,
            password: params.password,
            fullName: params.fullName,
            bio: params.bio,
            file: params.file==null
                ?null
                :await MultipartFile.fromFile(params.file!.path)
        )
    );
  }
}


class SignupUseCaseInput{
  final String email;
  final String password;
  final String fullName;
  final String bio;
  final File? file;

  SignupUseCaseInput({
    required this.email,
    required this.password,
    required this.fullName,
    required this.bio,
    this.file
  });

}