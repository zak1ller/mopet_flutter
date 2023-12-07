import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Keys {
  static const jwt = "jwt";
  static const nickname = "nickname";
  static const mode = "mode";
  static const userId = "user_id";

  static Future<Map<String, String>> headers() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final jwt = SharedPreferencesManager.prefs.getString(Keys.jwt);
    var os = "";
    var device = "";
    final version = packageInfo.version;

    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      os = "Android ${info.version.sdkInt}";
      device = info.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      os = "iOS ${info.systemVersion}";
      device = info.utsname.machine;
    }

    return {
      "x-access-token": jwt ?? "",
      "OS": os,
      "DEVICE": device,
      "MOPET": version,
    };
  }
}
