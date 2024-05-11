
import 'dart:io';

import 'package:dio/dio.dart';


class RegisterBaseRequestBase {
  final String fullName;
  final String avatarUrl;
  final MultipartFile? file;
  final String bio;
  final bool isVegan;
  final int hungryHeads;
  final List<String> categories;
  final String deviceInfo;
  final String deviceId;

  RegisterBaseRequestBase({
    required this.fullName,
    required this.bio,
    required this.avatarUrl,
    this.file,
    required this.isVegan,
    required this.hungryHeads,
    required this.categories,
    required this.deviceInfo,
    required this.deviceId
  });
  Map<String, dynamic> toJson(){
    return {
      "fullName": fullName,
      "bio": bio,
      "avatarUrl": avatarUrl,
      "file": file,
      "isVegan": isVegan,
      "hungryHeads": hungryHeads,
      "categories": categories,
      "deviceInfo": deviceInfo,
      "deviceId": deviceId
    };
  }
}



class RegisterWithEmailRequest extends RegisterBaseRequestBase {
  final String email;
  final String password;

  RegisterWithEmailRequest({
    required this.email,required this.password,
    required String fullName,
    required String bio,
    required String avatarUrl,
    MultipartFile? file,
    required bool isVegan,
    required int hungryHeads,
    required List<String> categories,
    required String deviceInfo,
    required String deviceId
  }):
      super(
        fullName: fullName, bio: bio,
        avatarUrl: avatarUrl, file: file,
        isVegan: isVegan, hungryHeads: hungryHeads,
        categories: categories,
        deviceInfo: deviceInfo, deviceId: deviceId
      );

@override
  Map<String, dynamic> toJson()
  {
    var map = super.toJson();
    map["email"] = email;
    map["password"] = password;
    return map;
  }
}

class RegisterWithLoginIdRequest extends RegisterBaseRequestBase {
  final String loginId;
  final String linkedAccountType;


  RegisterWithLoginIdRequest({
    required this.loginId,
    required this.linkedAccountType,
    required String fullName,
    required String bio,
    required String avatarUrl,
    MultipartFile? file,
    required bool isVegan,
    required int hungryHeads,
    required List<String> categories,
    required String deviceInfo,
    required String deviceId}):
      super(
        fullName: fullName, bio: bio,
        avatarUrl: avatarUrl, file: file,
        isVegan: isVegan, hungryHeads: hungryHeads,
        categories: categories,
        deviceInfo: deviceInfo, deviceId: deviceId
      );
@override
  Map<String, dynamic> toJson()
  {
    var map = super.toJson();
    map["loginId"] = loginId;
    map["linkedAccountType"] = linkedAccountType;
    return map;
  }
}