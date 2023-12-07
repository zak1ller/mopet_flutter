import 'package:mopet/features/authentication/models/user_update_result_model.dart';

class UserUpdateResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final UserUpdateResultModel? result;

  UserUpdateResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory UserUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? UserUpdateResultModel.fromJson(json['result'])
          : null,
    );
  }
}
