class LoginRequest {
  final String? email;
  final String? password;
  final String? googleId;
  final String? facebookId;

  LoginRequest({this.email, this.password
    ,this.googleId,this.facebookId});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'googleId': googleId,
      'facebookId': facebookId,
    };
  }
}