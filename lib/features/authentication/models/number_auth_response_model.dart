import 'package:mopet/features/authentication/models/number_auth_result_model.dart';

class NumberAuthResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final NumberAuthResultModel? result;

  NumberAuthResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory NumberAuthResponseModel.fromJson(Map<String, dynamic> json) {
    return NumberAuthResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? NumberAuthResultModel.fromJson(json['result'])
          : null,
    );
  }
}
