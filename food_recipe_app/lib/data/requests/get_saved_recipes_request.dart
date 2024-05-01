class GetSavedRecipesRequest {
  List<String> categories;
  String searchTerm;

  GetSavedRecipesRequest(this.categories, this.searchTerm);

  Map<String, dynamic> toJson() {
    return {'categories': categories, 'searchTerm': searchTerm};
  }
}
