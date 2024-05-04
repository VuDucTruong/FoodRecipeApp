
import 'dart:io';

import 'package:dio/dio.dart';

class RegisterWithEmailRequest {
  final String email;
  final String password;
  final String fullName;
  final String bio;
  final MultipartFile? file;

  RegisterWithEmailRequest({
    required this.email,required this.password,
    required this.fullName,required this.bio,
    this.file});

  Map<String, dynamic> toJson()
  {
    return {
      "email": email,
      "password": password,
      "fullName": fullName,
      "bio": bio,
      "file": file
    };
    }
  }

class RegisterWithLoginIdRequest {
  final String loginId;
  final String fullName;
  final String bio;
  final MultipartFile? file;
  final String linkedAccountType;

  RegisterWithLoginIdRequest({
    required this.loginId,
    required this.fullName,required this.bio,
    required this.linkedAccountType,this.file});

  Map<String, dynamic> toJson()
  {
    return {
      "loginId": loginId,
      "fullName": fullName,
      "bio": bio,
      "file": file
    };
  }
}