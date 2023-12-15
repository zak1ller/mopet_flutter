class ProfileEditResponseModel {
  final bool isSuccess;
  final int code;
  final String message;

  ProfileEditResponseModel({
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  factory ProfileEditResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileEditResponseModel(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
    );
  }
}
