import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final String fullName;
  final MultipartFile? avatarImg;
  final bool isVegan;
  final String bio;
  final List<String> categories;
  final int hungryHeads;

  UpdateProfileRequest(this.fullName, this.avatarImg,
      this.isVegan, this.bio, this.categories, this.hungryHeads);
}