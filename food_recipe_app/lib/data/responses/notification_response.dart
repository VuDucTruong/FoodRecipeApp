import 'dart:ffi';

import 'package:food_recipe_app/data/responses/special_datatypes/uint_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AppNotificationResponse {
  final int offSet;
  final DateTime createdAt;
  final String? imageUrl;
  final String title;
  final String content;
  final bool isRead;
  final String? redirectPath;
  AppNotificationResponse({
    required this.offSet,
    required this.createdAt,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.isRead,
    required this.redirectPath,
  });
  factory AppNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);

  static List<AppNotificationResponse> fromJsonList(dynamic list) {
    List<AppNotificationResponse> notificationList = [];
    for (int i = 0; i < (list as List).length; i++) {
      if (list[i] != null) {
        notificationList.add(AppNotificationResponse.fromJson(list[i]));
      }
    }
    return notificationList;
  }

  @override
  String toString() {
    return 'NotificationDomainResponse{offSet: $offSet, createdAt: $createdAt, imageUrl: $imageUrl, title: $title, content: $content, isRead: $isRead, redirectPath: $redirectPath}';
  }
}
