class JwtCheckResultModel {
  final int userId;

  JwtCheckResultModel({
    required this.userId,
  });

  factory JwtCheckResultModel.fromJson(Map<String, dynamic> json) {
    return JwtCheckResultModel(
      userId: json['userId'],
    );
  }
}
