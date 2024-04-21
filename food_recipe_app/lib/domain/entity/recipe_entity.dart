class RecipeEntity {
  String id, userId, title, instruction;
  DateTime createdAt, updatedAt;
  List<String> attachmentUrls;
  int likes;
  List<String>? commentBatchIds;
  int cookTime;
  Map<String, String> ingredients;
  bool isPublished;

  RecipeEntity(
      this.id,
      this.userId,
      this.title,
      this.instruction,
      this.createdAt,
      this.updatedAt,
      this.attachmentUrls,
      this.likes,
      this.commentBatchIds,
      this.cookTime,
      this.ingredients,
      this.isPublished);
}
