class LoginRequest {
  final String? deviceId;
  final String? deviceInfo;
  final String? email;
  final String? password;
  final String? loginId;
  final String? linkedAccountType;

  LoginRequest({this.deviceId,this.deviceInfo,this.email, this.password
    ,this.loginId,this.linkedAccountType});

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceInfo': deviceInfo,
      'email': email,
      'password': password,
      'loginId': loginId,
    };
  }
}