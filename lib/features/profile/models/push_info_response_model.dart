import 'package:mopet/features/profile/models/push_info_result_model.dart';

class PushInfoResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final PushInfoResultModel? result;

  PushInfoResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory PushInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return PushInfoResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? PushInfoResultModel.fromJson(json['result'])
          : null,
    );
  }
}
