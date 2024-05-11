// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      offSet: (json['offSet'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      isRead: json['isRead'] as bool,
      redirectPath: json['redirectPath'] as String?,
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'offSet': instance.offSet,
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'content': instance.content,
      'isRead': instance.isRead,
      'redirectPath': instance.redirectPath,
    };
