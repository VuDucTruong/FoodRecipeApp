class LoginRequest {
  final String? deviceId;
  final String? deviceInfo;
  final String? email;
  final String? password;
  final String? googleId;
  final String? facebookId;

  LoginRequest({this.deviceId,this.deviceInfo,this.email, this.password
    ,this.googleId,this.facebookId});

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceInfo': deviceInfo,
      'email': email,
      'password': password,
      'googleId': googleId,
      'facebookId': facebookId,
    };
  }
}