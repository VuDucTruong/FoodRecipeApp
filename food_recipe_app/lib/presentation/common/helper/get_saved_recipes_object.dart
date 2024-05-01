class GetSavedRecipesObject {
  List<String> categories;
  String searchTerm;
  int page;

  GetSavedRecipesObject(
      {required this.categories, required this.searchTerm, this.page = 0});
}
