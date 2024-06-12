import 'dart:ffi';

class NotificationEntity{
  final int offSet;
  final DateTime createdAt;
  final String imageUrl;
  final String title;
  final String content;
  final bool isRead;
  final String redirectPath;
  NotificationEntity({
    required this.offSet,
    required this.createdAt,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.isRead,
    required this.redirectPath,
  });

  @override
  String toString() {
    return 'NotificationEntity{offSet: $offSet, createdAt: $createdAt, imageUrl: $imageUrl, title: $title, content: $content, isRead: $isRead, redirectPath: $redirectPath}';
  }
}