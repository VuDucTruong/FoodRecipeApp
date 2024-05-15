
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/background_data/device_info.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/login_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/bloc/food_type_bloc.dart';
import 'package:get_it/get_it.dart';

class SignupWithEmailUseCase implements BaseUseCase<SignupWithEmailUseCaseInput, void> {
  final LoginRepository _loginRepository;

  SignupWithEmailUseCase(this._loginRepository);

  @override
  Future<Either<Failure, void>> execute(SignupWithEmailUseCaseInput params) async {

    DeviceInfoParams deviceInfoParams = await GetIt.I.get<DeviceInfo>().getDeviceInfo();
    return await _loginRepository.registerWithEmail(
        RegisterWithEmailRepositoryDTO(
            email: params.email, password: params.password,
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


class SignupWithEmailUseCaseInput{
  final String email;
  final String password;
  final String fullName;
  final String avatarUrl;
  final MultipartFile? file;
  final String bio;
  final bool isVegan;
  final int hungryHeads;
  final List<String> categories;

  SignupWithEmailUseCaseInput({
    required this.email,
    required this.password,
    required this.fullName,
    required this.bio,
    required this.avatarUrl,
    this.file,
    required this.isVegan,
    required this.hungryHeads,
    required this.categories,
  });

  SignupWithEmailUseCaseInput.fromUserRegisterProfileAdvanced({
    required UserRegisterProfileAdvanced userRegisterProfileAdvanced,
  }):
        email = userRegisterProfileAdvanced.email!,
        password = userRegisterProfileAdvanced.password!,
        fullName = userRegisterProfileAdvanced.fullName,
        bio = userRegisterProfileAdvanced.bio,
        avatarUrl = userRegisterProfileAdvanced.avatarUrl??"",
        file = userRegisterProfileAdvanced.file,
        hungryHeads = userRegisterProfileAdvanced.hungryHeads,
        categories = userRegisterProfileAdvanced.categories,
        isVegan = userRegisterProfileAdvanced.isVegan;
}