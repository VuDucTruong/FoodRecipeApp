// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_domain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDomainResponse _$NotificationDomainResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationDomainResponse(
      offSet: const Uint32Converter().fromJson(json['offSet'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      isRead: json['isRead'] as bool,
      redirectPath: json['redirectPath'] as String,
    );

Map<String, dynamic> _$NotificationDomainResponseToJson(
        NotificationDomainResponse instance) =>
    <String, dynamic>{
      'offSet': const Uint32Converter().toJson(instance.offSet),
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'content': instance.content,
      'isRead': instance.isRead,
      'redirectPath': instance.redirectPath,
    };
