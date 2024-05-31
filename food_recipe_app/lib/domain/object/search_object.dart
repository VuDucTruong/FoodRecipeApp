class RecipeSearchObject {
  List<String> categories;
  String searchTerm;
  int page;

  RecipeSearchObject(this.categories, this.searchTerm, {this.page = 0});
}
