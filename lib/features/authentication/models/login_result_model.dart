class LoginResultModel {
  final String token;

  LoginResultModel({
    required this.token,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) {
    return LoginResultModel(
      token: json['token'],
    );
  }
}
