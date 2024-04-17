import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/data/responses/special_datatypes/headers_converter.dart';

class BaseResponse<T> {
  int? statusCode;
  String? statusMessage;
  T? data;
  @HeadersConverter()
  Headers? headers;

  BaseResponse({this.statusCode, this.statusMessage, this.data, this.headers});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    debugPrint('in base response: ${json.toString()}');
    return BaseResponse<T>(
      statusCode: json['statusCode'] as int??0,
      statusMessage: json['statusMessage'] as String??'hallo',
      data: json['data'] == null ? null : fromJsonT(json['data']),
      // headers: const HeadersConverter().fromJson(json['headers'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic>? Function(T value) toJsonT) {
    return <String, dynamic>{
      'status': statusCode,
      'message': statusMessage,
      // 'data': data == null ? null : toJsonT!(this.data!),
      // 'headers': const HeadersConverter().toJson(headers),
    };
  }
}
