import 'package:mopet/features/authentication/models/terms_result_model.dart';

class TermsResponseModel {
  final bool isSuccess;
  final int code;
  final String message;
  final TermsResultModel? result;

  TermsResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory TermsResponseModel.fromJson(Map<String, dynamic> json) {
    return TermsResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json['result'] != null
          ? TermsResultModel.fromJson(json['result'])
          : null,
    );
  }
}
