import 'dart:ffi';

class CommentEntity {
  final String offSet;
  final DateTime createdAt;
  final int rating;
  final String content;
  final List<String> attachmentUrls;
  CommentEntity({
    required this.offSet,
    required this.createdAt,
    required this.rating,
    required this.content,
    required this.attachmentUrls,
  });
}
