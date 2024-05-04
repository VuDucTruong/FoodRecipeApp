
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class SignupWithLoginIdUseCase implements BaseUseCase<SignupWithLoginIdUseCaseInput, void> {
  final LoginRepository _loginRepository;

  SignupWithLoginIdUseCase(this._loginRepository);

  @override
  Future<Either<Failure, void>> execute(SignupWithLoginIdUseCaseInput params) async {
    return await _loginRepository.registerWithLoginId(
        RegisterWithLoginIdDTOs(
          loginId: params.loginId,
            fullName: params.fullName,
            bio: params.bio,
            avatarUrl: params.avatarUrl,
            file: params.file,
            linkedAccountType: params.linkedAccountType
        )
    );
  }
}


class SignupWithLoginIdUseCaseInput{
  final String loginId;
  final String fullName;
  final String bio;
  final String avatarUrl;
  final MultipartFile? file;
  final String linkedAccountType;

  SignupWithLoginIdUseCaseInput({
    required this.loginId,
    required this.fullName,
    required this.bio,
    required this.avatarUrl,
    this.file,
    required this.linkedAccountType
  });

}