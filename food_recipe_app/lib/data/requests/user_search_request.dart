import 'package:food_recipe_app/domain/repository/user_repository.dart';

class UserSearchRequest {
  String search;
  int page;

  UserSearchRequest({required this.search, this.page = 0});

  UserSearchRequest.fromUserSearchRequestDto(UserSearchRequestDto request)
      : search = request.search,
        page = request.page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['page'] = page;
    return data;
  }
}