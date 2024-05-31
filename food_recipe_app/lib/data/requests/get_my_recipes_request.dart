class GetMyRecipesRequest {
  List<String> categories;
  String? searchTerm;
  int page;

  GetMyRecipesRequest(this.categories, this.searchTerm, this.page);

  Map<String, dynamic> toJson() {
    return {"categories": categories, "searchTerm": searchTerm, "page": page};
  }
}
