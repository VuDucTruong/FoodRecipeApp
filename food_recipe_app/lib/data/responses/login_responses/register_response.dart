import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/domain_responses/user_domain_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';
@JsonSerializable(explicitToJson: true)
class RegisterResponse extends BaseResponse{
  final String? accessToken;
  final String? refreshToken;
  final UserDomainResponse? user;
  RegisterResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
// khai báo json ở đây
  factory RegisterResponse.fromJson(Map<String, dynamic> json)
  => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

}

