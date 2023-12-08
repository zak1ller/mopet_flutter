import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/base_url.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/profile/models/push_info_response_model.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<PushInfoResponseModel?> fetchPushInfo() async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/users/setting/push");
    final headers = await Keys.headers();
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return PushInfoResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<void> patchPushValue(bool pushFeed, bool pushMarketing) async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/users/setting/push");

    var feed = pushFeed ? "1" : "0";
    var marketing = pushMarketing ? "1" : "0";

    Map<String, String> param = {
      "pushFeed": feed,
      "pushMarketing": marketing,
    };

    final headers = await Keys.headers();
    final response = await http.patch(
      uri,
      body: param,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("성공!");
    } else {
      print("실패!");
    }
  }
}

final profileRepo = Provider((ref) => ProfileRepository());
