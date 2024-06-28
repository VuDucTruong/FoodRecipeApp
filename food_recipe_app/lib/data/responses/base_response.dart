import 'package:dio/dio.dart';

class BaseResponse<T> {
  int? statusCode;
  String? statusMessage;
  T? data;

  BaseResponse({this.statusCode, this.statusMessage, this.data});

  factory BaseResponse.fromJson(
      Response response, T Function(dynamic) fromJsonT) {
    // final myData = response.data;
    // T myValue;
    // if (myData is Map<String, dynamic>) {
    //   myValue = fromJsonT(myData);
    // } else if (myData is List) {
    //   myValue = myData.map((e) => fromJsonT(e)).toList() as T;
    // } else {
    //   myValue = myData as T;
    // }
    return BaseResponse<T>(
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      data: response.data == null ? null : fromJsonT(response.data),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic>? Function(T value) toJsonT) {
    return <String, dynamic>{
      'status': statusCode,
      'message': statusMessage,
      'data': data == null ? null : toJsonT(this.data as T),
    };
  }
}
