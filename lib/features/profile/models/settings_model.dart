class SettingsModel {
  final String? username;
  final String? provider;
  final bool feedPush;
  final bool marketingPush;
  final String appVersion;
  final String? errorMessage;

  SettingsModel({
    required this.username,
    required this.provider,
    required this.feedPush,
    required this.marketingPush,
    required this.appVersion,
    required this.errorMessage,
  });

  SettingsModel copyWith({
    String? username,
    String? provider,
    bool? feedPush,
    bool? marketingPush,
    String? appVersion,
    String? errorMessage,
  }) {
    return SettingsModel(
      username: username ?? this.username,
      provider: provider ?? this.provider,
      feedPush: feedPush ?? this.feedPush,
      marketingPush: marketingPush ?? this.marketingPush,
      appVersion: appVersion ?? this.appVersion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
