import 'dart:io';

class ProfileEditModel {
  final String username;
  final String petname;
  final bool isValidPetname;
  final String petBirthday;
  final bool isValidPetBirthday;
  final String petType;
  final bool isVaildPetType;
  final bool enableFinishButton;
  final File profileImage;

  ProfileEditModel({
    required this.username,
    required this.petname,
    required this.isValidPetname,
    required this.petBirthday,
    required this.isValidPetBirthday,
    required this.petType,
    required this.isVaildPetType,
    required this.enableFinishButton,
    required this.profileImage,
  });

  static ProfileEditModel empty() {
    return ProfileEditModel(
      username: "",
      petname: "",
      isValidPetname: false,
      petBirthday: "",
      isValidPetBirthday: false,
      petType: "",
      isVaildPetType: false,
      enableFinishButton: false,
      profileImage: File(''),
    );
  }

  factory ProfileEditModel.fromJson(Map<String, dynamic> json) {
    return ProfileEditModel(
      username: json['username'],
      petname: json['petname'],
      isValidPetname: json['isValidPetname'],
      petBirthday: json['petBirthday'],
      isValidPetBirthday: json['isValidPetBirthday'],
      petType: json['petType'],
      isVaildPetType: json['isVaildPetType'],
      enableFinishButton: json['enableFinishButton'],
      profileImage: json['profileImage'],
    );
  }

  ProfileEditModel copyWith({
    String? username,
    String? petname,
    bool? isValidPetname,
    String? petBirthday,
    bool? isValidPetBirthday,
    String? petType,
    bool? isVaildPetType,
    bool? enableFinishButton,
    File? profileImage,
    bool? isLoading,
  }) {
    return ProfileEditModel(
      username: username ?? this.username,
      petname: petname ?? this.petname,
      isValidPetname: isValidPetname ?? this.isValidPetname,
      petBirthday: petBirthday ?? this.petBirthday,
      isValidPetBirthday: isValidPetBirthday ?? this.isValidPetBirthday,
      petType: petType ?? this.petType,
      isVaildPetType: isVaildPetType ?? this.isVaildPetType,
      enableFinishButton: enableFinishButton ?? this.enableFinishButton,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
