import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/app_prefs.dart';

extension ResponseExtension<T> on Response {
  Map<String,dynamic> toMap(){
    return{
      'data': data,
      'statusCode':statusCode,
      'statusMessage':statusMessage,
      'headers':headers.toJson(),
    };
  }
}
extension HeadersLoggingExtension on Headers {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {};
    forEach((key, value) {
      jsonMap[key] = value.join(', ');
    });
    return jsonMap;
  }
}

