class ProfileCheckResultModel {
  final int userId;
  final String nickname;
  final String petName;
  final String petType;
  final String petBirthday;
  final String? profileImage;

  ProfileCheckResultModel({
    required this.userId,
    required this.nickname,
    required this.petName,
    required this.petType,
    required this.petBirthday,
    required this.profileImage,
  });

  factory ProfileCheckResultModel.fromJson(Map<String, dynamic> json) {
    return ProfileCheckResultModel(
      userId: json['userId'],
      nickname: json['nickname'],
      petName: json['petName'],
      petType: json['petType'],
      petBirthday: json['petBirthday'],
      profileImage: json['profileImage'],
    );
  }
}
