import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

class HeadersConverter implements JsonConverter<Headers?, Map<String, dynamic>?> {
  const HeadersConverter();

  @override
  Headers? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    Headers headers = Headers();
    json.forEach((key, value) {
      headers.add(key, value);
    });
    return headers;
  }

  @override
  Map<String, dynamic>? toJson(Headers? headers) {
    if (headers == null || headers.isEmpty) return null;

    Map<String, dynamic> json = {};
    headers.forEach((key, value) {
      json[key] = value.join(', ');
    });
    return json;
  }
}
