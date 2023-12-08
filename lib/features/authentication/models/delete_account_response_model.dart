class DeleteAccountResponseModel {
  final bool isSuccess;
  final int code;
  final String message;

  DeleteAccountResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
  });
  
  factory DeleteAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
    );
  }
}
