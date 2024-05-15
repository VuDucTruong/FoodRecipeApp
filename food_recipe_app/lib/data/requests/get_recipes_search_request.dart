import 'package:food_recipe_app/domain/repository/recipe_respository.dart';

class GetRecipesSearchRequest {
  List<String> categories;
  String searchTerm;
  int page;

  GetRecipesSearchRequest({required this.categories,required this.searchTerm, this.page=1});
  GetRecipesSearchRequest.fromGetRecipesSearchRequestDto(GetRecipesSearchRequestDto request):
        categories = request.categories,
        searchTerm = request.searchTerm,
        page = request.page;

  Map<String, dynamic> toJson() {
    return {'categories': categories, 'searchTerm': searchTerm, 'page': page};
  }
}
