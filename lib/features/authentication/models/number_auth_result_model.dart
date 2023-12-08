class NumberAuthResultModel {
  final int remainCount;

  NumberAuthResultModel({
    required this.remainCount,
  });

  factory NumberAuthResultModel.fromJson(Map<String, dynamic> json) {
    return NumberAuthResultModel(
      remainCount: json['remainCount'],
    );
  }
}
