import 'package:mopet/features/authentication/models/login_result_model.dart';

class LoginResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final LoginResultModel? result;

  LoginResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? LoginResultModel.fromJson(json['result'])
          : null,
    );
  }
}
