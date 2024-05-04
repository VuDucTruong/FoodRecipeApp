part of 'food_type_bloc.dart';

@immutable
sealed class FoodTypeEvent {}

class FoodTypeSubmit extends FoodTypeEvent {
  final UserRegisterProfileAdvanced userRegisterProfile;

  FoodTypeSubmit({required this.userRegisterProfile});
}


class UserRegisterProfileAdvanced extends FoodTypeEvent {
  final String? loginId;
  final String fullName;
  final String? email;
  final String? password;
  final String bio;
  final String linkedAccountType;
  final String? avatarUrl;
  final MultipartFile? file;
  final int hungryHeads;
  final List<String> categories;

  UserRegisterProfileAdvanced({required UserRegisterProfileBasics userRegisterProfile,
  required this.hungryHeads,required this.categories}):
        loginId = userRegisterProfile.loginId,
        fullName = userRegisterProfile.fullName,
        email = userRegisterProfile.email,
        password = userRegisterProfile.password,
        bio = userRegisterProfile.bio,
        linkedAccountType = userRegisterProfile.linkedAccountType,
        avatarUrl = userRegisterProfile.avatarUrl,
        file = userRegisterProfile.file;
}

