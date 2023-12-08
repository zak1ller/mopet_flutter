class PushInfoResultModel {
  final bool pushFeed;
  final bool pushMarketing;

  PushInfoResultModel({
    required this.pushFeed,
    required this.pushMarketing,
  });

  factory PushInfoResultModel.fromJson(Map<String, dynamic> json) {
    return PushInfoResultModel(
      pushFeed: json['pushFeed'],
      pushMarketing: json['pushMarketing'],
    );
  }
}
