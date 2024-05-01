class RecipeEntity {
  String id;
  String userId;
  String title;
  String description;
  String instruction;
  DateTime createdAt;
  DateTime updatedAt;
  int representIndex;
  List<String> attachmentUrls;
  String categories;
  int likes;
  int serves;
  int cookTime;
  List<String> ingredients;
  bool isPublished;
  bool isVegan;

  RecipeEntity(
      this.id,
      this.userId,
      this.title,
      this.description,
      this.instruction,
      this.createdAt,
      this.updatedAt,
      this.representIndex,
      this.attachmentUrls,
      this.categories,
      this.likes,
      this.serves,
      this.cookTime,
      this.ingredients,
      this.isPublished,
      this.isVegan);

  @override
  String toString() {
    return 'RecipeEntity{id: $title}';
  }
}
