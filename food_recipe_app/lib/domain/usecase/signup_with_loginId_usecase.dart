
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/presentation/utils/device_info.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/bloc/food_type_bloc.dart';
import 'package:get_it/get_it.dart';

class SignupWithLoginIdUseCase implements BaseUseCase<SignupWithLoginIdUseCaseInput, void> {
  final LoginRepository _loginRepository;

  SignupWithLoginIdUseCase(this._loginRepository);

  @override
  Future<Either<Failure, void>> execute(SignupWithLoginIdUseCaseInput params) async {
    DeviceInfoParams deviceInfoParams = await GetIt.instance.get<DeviceInfo>().getDeviceInfo();
    return await _loginRepository.registerWithLoginId(
        RegisterWithLoginIdDTOs(
          loginId: params.loginId, linkedAccountType: params.linkedAccountType,
          fullName: params.fullName, bio: params.bio,
          avatarUrl: params.avatarUrl, file: params.file,
          isVegan: params.isVegan, hungryHeads: params.hungryHeads,
          categories: params.categories,
          deviceId: deviceInfoParams.deviceId,
          deviceInfo: deviceInfoParams.deviceInfo,
        )
    );
  }
}


class SignupWithLoginIdUseCaseInput{
  final String loginId;
  final String linkedAccountType;
  final String fullName;
  final String avatarUrl;
  final MultipartFile? file;
  final String bio;
  final bool isVegan;
  final int hungryHeads;
  final List<String> categories;

  SignupWithLoginIdUseCaseInput({
    required this.loginId, required this.linkedAccountType,
    required this.fullName, required this.bio,
    required this.avatarUrl, this.file,
    required this.isVegan, required this.hungryHeads,
    required this.categories,
  });
  SignupWithLoginIdUseCaseInput.fromUserRegisterProfileAdvanced({
    required UserRegisterProfileAdvanced userRegisterProfileAdvanced,
  }):
        loginId = userRegisterProfileAdvanced.loginId!,
        linkedAccountType = userRegisterProfileAdvanced.linkedAccountType,
        fullName = userRegisterProfileAdvanced.fullName,
        bio = userRegisterProfileAdvanced.bio,
        avatarUrl = userRegisterProfileAdvanced.avatarUrl??"",
        file = userRegisterProfileAdvanced.file,
        hungryHeads = userRegisterProfileAdvanced.hungryHeads,
        categories = userRegisterProfileAdvanced.categories,
        isVegan = userRegisterProfileAdvanced.isVegan;

}