import 'package:mopet/features/authentication/models/jwt_check_result_model.dart';

class JwtCheckResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final JwtCheckResultModel? result;

  JwtCheckResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory JwtCheckResponseModel.fromJson(Map<String, dynamic> json) {
    return JwtCheckResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? JwtCheckResultModel.fromJson(json['result'])
          : null,
    );
  }
}
