import 'package:mopet/features/profile/models/profile_check_result_model.dart';

class ProfileCheckResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final ProfileCheckResultModel? result;

  ProfileCheckResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ProfileCheckResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileCheckResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? ProfileCheckResultModel.fromJson(json['result'])
          : null,
    );
  }
}
