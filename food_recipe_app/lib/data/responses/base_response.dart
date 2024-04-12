import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';


@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}