class NumberAuthResultModel {
  final String authCount;

  NumberAuthResultModel({
    required this.authCount,
  });

  factory NumberAuthResultModel.fromJson(Map<String, dynamic> json) {
    return NumberAuthResultModel(
      authCount: json['authCount'],
    );
  }
}
