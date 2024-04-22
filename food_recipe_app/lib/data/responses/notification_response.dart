import 'dart:ffi';

import 'package:food_recipe_app/data/responses/special_datatypes/uint_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_domain_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationDomainResponse{
  final int offSet;
  final DateTime createdAt;
  final String? imageUrl;
  final String title;
  final String content;
  final bool isRead;
  final String? redirectPath;
  NotificationDomainResponse({
    required this.offSet,
    required this.createdAt,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.isRead,
    required this.redirectPath,
  });
  factory NotificationDomainResponse.fromJson(Map<String,dynamic> json)
  => _$NotificationDomainResponseFromJson(json);
  Map<String,dynamic> toJson() => _$NotificationDomainResponseToJson(this);
  @override
  String toString() {
    return 'NotificationDomainResponse{offSet: $offSet, createdAt: $createdAt, imageUrl: $imageUrl, title: $title, content: $content, isRead: $isRead, redirectPath: $redirectPath}';
  }
}