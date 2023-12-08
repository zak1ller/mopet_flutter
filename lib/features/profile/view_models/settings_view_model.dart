import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/profile/models/settings_model.dart';
import 'package:mopet/features/profile/repos/profile_repo.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsViewModel extends AsyncNotifier<SettingsModel> {
  @override
  FutureOr<SettingsModel> build() async {
    bool feedPush = false;
    bool marketingPush = false;
    String? errorMessage;
    PackageInfo info = await PackageInfo.fromPlatform();

    final pushResponse = await ref.read(profileRepo).fetchPushInfo();
    if (pushResponse != null) {
      if (pushResponse.result != null) {
        final result = pushResponse.result!;
        feedPush = result.pushFeed;
        marketingPush = result.pushMarketing;
      } else {
        errorMessage = pushResponse.message;
      }
    }

    return SettingsModel(
      username: SharedPreferencesManager.prefs.getString(Keys.nickname),
      provider: SharedPreferencesManager.prefs.getString(Keys.provider),
      feedPush: feedPush,
      marketingPush: marketingPush,
      appVersion: info.version,
      errorMessage: errorMessage,
    );
  }

  void updateFeedPush(bool feedPushValue) {
    final value = state.value;
    if (value != null) {
      state = AsyncValue.data(
        value.copyWith(
          feedPush: feedPushValue,
        ),
      );
      _updatePushToServer();
    }
  }

  void udpateMarketingPush(bool marketingPushValue) {
    final value = state.value;
    if (value != null) {
      state = AsyncValue.data(
        value.copyWith(
          marketingPush: marketingPushValue,
        ),
      );
      _updatePushToServer();
    }
  }

  void _updatePushToServer() {
    final value = state.value;
    if (value != null) {
      final repo = ref.read(profileRepo);
      repo.patchPushValue(value.feedPush, value.marketingPush);
    }
  }
}

final settingsProvider =
    AsyncNotifierProvider<SettingsViewModel, SettingsModel>(
  () => SettingsViewModel(),
);
