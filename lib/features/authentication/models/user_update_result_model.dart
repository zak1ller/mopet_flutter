class UserUpdateResultModel {
  final String mode;
  final String nickname;
  final int locationAccept;
  final int termsAccept;
  final int marketingAccept;
  final int isAdmin;
  final int userId;
  final String email;
  final String? profileImage;
  final String depth1;
  final String depth2;
  final String depth3;
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
    required this.depth1,
    required this.depth2,
    required this.depth3,
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
      depth1: json['depth1'],
      depth2: json['depth2'],
      depth3: json['depth3'],
      status: json['status'],
    );
  }
}
