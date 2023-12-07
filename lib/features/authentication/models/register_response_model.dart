class RegisterResponseModel {
  final bool isSuccess;
  final int code;
  final String message;

  RegisterResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
  });
  
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
    );
  }
}
