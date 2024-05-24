import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';

import '../entity/background_user.dart';

abstract class UserRepository {
  Future<Either<Failure, BackgroundUser>> getUserInfo();
  Future<Either<Failure, List<ChefEntity>>> getVerifiedChefs();
  Future<Either<Failure, ChefEntity>> getChefInfo(String id);
  Future<Either<Failure, ChefEntity>> getProfileById(String id);
  Future<Either<Failure, List<ChefEntity>>> getProfileSearch(
      UserSearchRequestDto searchRequest);
  Future<Either<Failure, ProfileInformation>> updateProfile(
      UserUpdateRequestDto updateRequest);
  Future<Either<Failure, bool>> deleteProfile();
  Future<Either<Failure, bool>> updatePassword(String password);
  Future<Either<Failure, bool>> updateFollow(String targetChefId, bool option);
}

class UserSearchRequestDto {
  String search;
  int page;
  UserSearchRequestDto({this.search = "", this.page = 0});
}

class UserUpdateRequestDto {
  final String fullName;
  final String? avatarUrl;
  final MultipartFile? avatarImg;
  final bool isVegan;
  final String bio;
  final List<String> categories;
  final int hungryHeads;
  UserUpdateRequestDto({
    required this.fullName,
    this.avatarUrl,
    this.avatarImg,
    required this.isVegan,
    required this.bio,
    required this.categories,
    required this.hungryHeads,
  });
}
