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
}