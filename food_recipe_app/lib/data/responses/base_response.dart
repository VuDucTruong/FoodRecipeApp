import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_recipe_app/data/responses/special_datatypes/headers_converter.dart';

class BaseResponse<T> {
  int? statusCode;
  String? statusMessage;
  T? data;

  BaseResponse({this.statusCode, this.statusMessage, this.data});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final myData = json['data'];
    T myValue;
    if(myData is Map<String, dynamic>) {
      myValue = fromJsonT(myData);
    }
    else if(myData is List) {
      myValue = myData.map((e) => fromJsonT(e)).toList() as T;
    }
    else {
      myValue = myData as T;
    }
    return BaseResponse<T>(
      statusCode: json['statusCode'] as int?,
      statusMessage: json['statusMessage'] as String?,
      data: myValue,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic>? Function(T value) toJsonT) {
    return <String, dynamic>{
      'status': statusCode,
      'message': statusMessage,
      'data': data == null ? null : toJsonT(this.data!),
    };
  }
}
