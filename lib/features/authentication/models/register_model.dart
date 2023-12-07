import 'dart:io';

class RegisterModel {
  final String username;
  final bool isValidUsername;
  final String petname;
  final bool isValidPetname;
  final String petBirthday;
  final bool isValidPetBirthday;
  final String petType;
  final bool isVaildPetType;
  final bool enableFinishButton;
  final File profileImage;
  final bool isLoading;

  RegisterModel({
    required this.username,
    required this.isValidUsername,
    required this.petname,
    required this.isValidPetname,
    required this.petBirthday,
    required this.isValidPetBirthday,
    required this.petType,
    required this.isVaildPetType,
    required this.enableFinishButton,
    required this.profileImage,
    this.isLoading = false,
  });

  RegisterModel copyWith({
    String? username,
    bool? isValidUsername,
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
    return RegisterModel(
      username: username ?? this.username,
      isValidUsername: isValidUsername ?? this.isValidUsername,
      petname: petname ?? this.petname,
      isValidPetname: isValidPetname ?? this.isValidPetname,
      petBirthday: petBirthday ?? this.petBirthday,
      isValidPetBirthday: isValidPetBirthday ?? this.isValidPetBirthday,
      petType: petType ?? this.petType,
      isVaildPetType: isVaildPetType ?? this.isVaildPetType,
      enableFinishButton: enableFinishButton ?? this.enableFinishButton,
      profileImage: profileImage ?? this.profileImage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  RegisterModel reset() {
    return RegisterModel(
      username: "",
      isValidUsername: false,
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
}
