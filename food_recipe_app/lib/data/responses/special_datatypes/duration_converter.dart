import 'package:json_annotation/json_annotation.dart';

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) {
    return Duration(seconds: json);
  }

  @override
  int toJson(Duration object) {
    return object.inSeconds;
  }
}
