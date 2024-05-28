
import 'package:dio/dio.dart';
import 'package:food_recipe_app/domain/repository/user_repository.dart';

class UserUpdateRequest {
  final String fullName;
  final String? avatarUrl;
  final MultipartFile? avatarImg;
  final bool isVegan;
  final String? googleLink;
  final String? facebookLink;
  final String bio;
  final List<String> categories;
  final int hungryHeads;
  UserUpdateRequest({
    required this.fullName,
    this.avatarUrl,
    this.avatarImg,
    required this.isVegan,
    required this.bio,
    required this.categories,
    required this.hungryHeads,
    required this.googleLink,
    required this.facebookLink,
  });
  UserUpdateRequest.fromUserUpdateRequestDto(UserUpdateRequestDto request)
      : fullName = request.fullName,
        avatarUrl = request.avatarUrl,
        avatarImg = request.avatarImg,
        isVegan = request.isVegan,
        bio = request.bio,
        categories = request.categories,
        googleLink = request.googleLink,
        facebookLink = request.facebookLink,
        hungryHeads = request.hungryHeads;

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'avatarImg': avatarImg,
      'isVegan': isVegan,
      'bio': bio,
      'categories': categories,
      'googleLink': googleLink,
      'facebookLink': facebookLink,
      'hungryHeads': hungryHeads,
    };
  }
}