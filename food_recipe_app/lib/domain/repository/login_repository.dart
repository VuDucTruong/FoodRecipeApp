

import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> loginWithGoogle(String loginId);
  Future<Either<Failure, UserEntity>> loginWithFacebook(String loginId);
  Future<Either<Failure, void>> registerWithEmail(RegisterWithEmailRepositoryDTO registerWithEmailRepositoryDTO);
  Future<Either<Failure, void>> registerWithLoginId(RegisterWithLoginIdDTOs registerWithLoginIdDTOs);
  Future<Either<Failure, String>> refreshAccessToken();
  Future<Either<Failure, bool>> forgotPassword(String email);

}

class _LoginRepositoryDTOBase{
  final String fullName;
  final MultipartFile? file;
  final String bio;

  _LoginRepositoryDTOBase({
    required this.fullName,
    this.file,
    required this.bio
});
}



class RegisterWithEmailRepositoryDTO extends _LoginRepositoryDTOBase{
  final String email;
  final String password;

  RegisterWithEmailRepositoryDTO({
    required this.email,required this.password,
    required String fullName,
    MultipartFile? file, String? bio}):
        super(
    fullName: fullName,
    file: file,
    bio: bio??"");
}

class RegisterWithLoginIdDTOs extends _LoginRepositoryDTOBase{
  final String loginId;

  RegisterWithLoginIdDTOs({
    required this.loginId,
    required String fullName,
    MultipartFile? file, String? bio}):
        super(
          fullName: fullName,
          file: file,
          bio: bio??"");
}