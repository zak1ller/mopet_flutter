class NumberAuthModel {
  String phoneNumber;
  bool isValidNumber;
  bool isCertifiedAuthNumber;

  NumberAuthModel({
    required this.phoneNumber,
    required this.isValidNumber,
    required this.isCertifiedAuthNumber,
  });

  NumberAuthModel copyWith({
    String? phoneNumber,
    bool? isValidNumber,
    bool? isCertifiedAuthNumber,
    String? authCount,
  }) {
    return NumberAuthModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValidNumber: isValidNumber ?? this.isValidNumber,
      isCertifiedAuthNumber:
          isCertifiedAuthNumber ?? this.isCertifiedAuthNumber,
    );
  }
}
