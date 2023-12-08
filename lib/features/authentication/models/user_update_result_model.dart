class UserUpdateResultModel {
  final String mode;
  final String nickname;
  final int locationAccept;
  final int termsAccept;
  final int marketingAccept;
  final int isAdmin;
  final int userId;
  final String? email;
  final String? profileImage;
  final String status;

  UserUpdateResultModel({
    required this.mode,
    required this.nickname,
    required this.locationAccept,
    required this.termsAccept,
    required this.marketingAccept,
    required this.isAdmin,
    required this.userId,
    required this.email,
    required this.profileImage,
    required this.status,
  });

  factory UserUpdateResultModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateResultModel(
      mode: json['mode'],
      nickname: json['nickname'],
      locationAccept: json['locationAccept'],
      termsAccept: json['termsAccept'],
      marketingAccept: json['marketingAccept'],
      isAdmin: json['isAdmin'],
      userId: json['userId'],
      email: json['email'],
      profileImage: json['profileImage'],
      status: json['status'],
    );
  }
}
