

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
  final String avatarUrl;
  final MultipartFile? file;
  final String bio;
  final bool isVegan;
  final int hungryHeads;
  final List<String> categories;
  final String deviceInfo;
  final String deviceId;

  _LoginRepositoryDTOBase({
    required this.fullName,
    required this.bio,
    required this.avatarUrl,
    this.file,
    required this.isVegan,
    required this.hungryHeads,
    required this.categories,
    required this.deviceInfo,
    required this.deviceId
});
}



class RegisterWithEmailRepositoryDTO extends _LoginRepositoryDTOBase{
  final String email;
  final String password;

  RegisterWithEmailRepositoryDTO({
    required this.email,required this.password,
    required String fullName,
    required String bio,
    required String avatarUrl,
    MultipartFile? file,
    required bool isVegan,
    required int hungryHeads,
    required List<String> categories,
    required String deviceInfo,
    required String deviceId}):
        super(
          fullName: fullName, bio: bio,
          avatarUrl: avatarUrl, file: file,
          isVegan: isVegan, hungryHeads: hungryHeads,
          categories: categories,
          deviceInfo: deviceInfo, deviceId: deviceId
      );
}

class RegisterWithLoginIdDTOs extends _LoginRepositoryDTOBase{
  final String loginId;
  final String linkedAccountType;

  RegisterWithLoginIdDTOs({
    required this.loginId,
    required this.linkedAccountType,
    required String fullName,
    required String bio,
    required String avatarUrl,
    MultipartFile? file,
    required bool isVegan,
    required int hungryHeads,
    required List<String> categories,
    required String deviceInfo,
    required String deviceId}):
        super(
          fullName: fullName, bio: bio,
          avatarUrl: avatarUrl, file: file,
          isVegan: isVegan, hungryHeads: hungryHeads,
          categories: categories,
          deviceInfo: deviceInfo, deviceId: deviceId
      );
}