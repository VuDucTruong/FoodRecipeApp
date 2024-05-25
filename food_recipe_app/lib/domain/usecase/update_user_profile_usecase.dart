import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';
import 'package:food_recipe_app/domain/usecase/base_usecase.dart';

class UpdateUserProfileUseCase extends BaseUseCase<UpdateProfileUseCaseInput , ProfileInformation> {

  UserRepository userRepository;

  UpdateUserProfileUseCase(this.userRepository);


  @override
  Future<Either<Failure, ProfileInformation>> execute(UpdateProfileUseCaseInput input) {
    return userRepository.updateProfile(UserUpdateRequestDto.fromProfileInformation(input.profileInformation,input.avatar));
  }
}

class UpdateProfileUseCaseInput{
  final ProfileInformation profileInformation;
  final MultipartFile? avatar;

  UpdateProfileUseCaseInput(this.profileInformation, this.avatar);
}