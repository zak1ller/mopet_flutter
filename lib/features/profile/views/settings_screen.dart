import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/features/authentication/view_models/login_view_model.dart';
import 'package:mopet/features/authentication/views/terms_of_use_detail_screen.dart';
import 'package:mopet/features/profile/view_models/settings_view_model.dart';
import 'package:mopet/features/profile/views/widgets/terms_of_use_item2.dart';
import 'package:mopet/features/profile/views/widgets/title_switch.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static const routeName = "settings";
  static const routeUrl = "/settings";

  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _onChangedFeedNotificationValue(bool value) {
    ref.read(settingsProvider.notifier).updateFeedPush(value);
  }

  void _onChangedMarketingNotificationValue(bool value) {
    ref.read(settingsProvider.notifier).udpateMarketingPush(value);
  }

  void _privacyTap() {
    _showTermsOsUseDetailPage(1);
  }

  void _termsOfUseTap() {
    _showTermsOsUseDetailPage(2);
  }

  void _locationTap() {
    _showTermsOsUseDetailPage(3);
  }

  void _marketingTap() {
    _showTermsOsUseDetailPage(4);
  }

  void _showTermsOsUseDetailPage(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TermsOfUseDetailScreen(termsId: id),
      ),
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("settings_logout_dialog_title").tr(),
          actions: <Widget>[
            TextButton(
              child: const Text("cancel_button").tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("logout_button").tr(),
              onPressed: () {
                Navigator.pop(context);
                ref.read(loginProvider.notifier).logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _onDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("settings_delete_account_dialog_title").tr(),
          actions: <Widget>[
            TextButton(
              child: const Text("cancel_button").tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("delete_account_button").tr(),
              onPressed: () {
                Navigator.pop(context);
                ref.read(loginProvider.notifier).deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings_title").tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: MopetColor.light02,
              height: 56,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "settings_user_login_info",
                      style: MopetTextStyle.p50016
                          .copyWith(color: MopetColor.light07),
                    ).tr(
                      namedArgs: {
                        "username":
                            ref.watch(settingsProvider).value?.username ?? "?",
                        "provider":
                            ref.watch(settingsProvider).value?.provider ?? "?",
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "settings_notification_and_permission_title",
                    style: MopetTextStyle.p50016
                        .copyWith(color: MopetColor.light04),
                  ).tr(),
                  Gaps.v(10),
                  TitleSwitch(
                    title:
                        "settings_notification_and_permission_item_feed_notification",
                    isOn: ref.watch(settingsProvider).value?.feedPush ?? false,
                    onChanged: _onChangedFeedNotificationValue,
                  ),
                  TitleSwitch(
                    title:
                        "settings_notification_and_permission_item_marketing_notification",
                    isOn: ref.watch(settingsProvider).value?.marketingPush ??
                        false,
                    onChanged: _onChangedMarketingNotificationValue,
                  ),
                ],
              ),
            ),
            Container(
              color: MopetColor.light03,
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "settings_app_info_title",
                    style: MopetTextStyle.p50016
                        .copyWith(color: MopetColor.light04),
                  ).tr(),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    ref.watch(settingsProvider).value?.appVersion ?? "unknown",
                    style: MopetTextStyle.p50016
                        .copyWith(color: MopetColor.light07),
                  ),
                ],
              ),
            ),
            Container(
              color: MopetColor.light03,
              height: 8,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "settings_terms_of_use_title",
                      style: MopetTextStyle.p50016
                          .copyWith(color: MopetColor.light04),
                    ).tr(),
                    Gaps.v(18),
                    TermsOfUseItem2(
                      title: "settings_terms_of_use_item_privacy",
                      onTap: _privacyTap,
                    ),
                    Gaps.v(18),
                    TermsOfUseItem2(
                      title: "settings_terms_of_use_item_service",
                      onTap: _termsOfUseTap,
                    ),
                    Gaps.v(18),
                    TermsOfUseItem2(
                      title: "settings_terms_of_use_item_location",
                      onTap: _locationTap,
                    ),
                    Gaps.v(18),
                    TermsOfUseItem2(
                      title: "settings_terms_of_use_item_marketing",
                      onTap: _marketingTap,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: MopetColor.light03,
              height: 8,
            ),
            GestureDetector(
              onTap: _onLogout,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "settings_logout_button",
                    style: MopetTextStyle.p50016
                        .copyWith(color: MopetColor.light04),
                  ).tr(),
                ),
              ),
            ),
            Container(
              color: MopetColor.light03,
              height: 8,
            ),
            GestureDetector(
              onTap: _onDeleteAccount,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "settings_delete_account_button",
                    style: MopetTextStyle.p50016
                        .copyWith(color: MopetColor.light04),
                  ).tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
