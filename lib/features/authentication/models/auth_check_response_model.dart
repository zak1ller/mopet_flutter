class AuthCheckResponseModel {
  final bool isSuccess;
  final int code;
  final String message;

  AuthCheckResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  factory AuthCheckResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthCheckResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
    );
  }
}
