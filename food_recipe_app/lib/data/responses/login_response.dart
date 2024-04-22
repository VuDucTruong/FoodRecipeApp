import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/domain_responses/user_domain_response.dart';
import 'package:food_recipe_app/data/responses/special_datatypes/headers_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';
@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserDomainResponse user;
 LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
// khai báo json ở đây
 factory LoginResponse.fromJson(Map<String, dynamic> json)
  => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}

