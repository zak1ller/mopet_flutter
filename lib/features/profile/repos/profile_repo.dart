import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/base_url.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/profile/models/profile_check_response_model.dart';
import 'package:mopet/features/profile/models/profile_edit_response_model.dart';
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
    await http.patch(
      uri,
      body: param,
      headers: headers,
    );
    // final response = await http.patch(
    //   uri,
    //   body: param,
    //   headers: headers,
    // );

    // if (response.statusCode == 200) {
    //   print("성공!");
    // } else {
    //   print("실패!");
    // }
  }

  Future<ProfileCheckResponseModel?> fetchProfileCheck() async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/users/profile/check");
    final headers = await Keys.headers();
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return ProfileCheckResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<ProfileEditResponseModel?> patchProfile({
    required String uid,
    required File profileImage,
    required String petname,
    required String petBirthday,
    required String petType,
  }) async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/v3/users/profile");
    final headers = await Keys.headers();

    var request = http.MultipartRequest("PATCH", uri)
      ..fields['userId'] = uid
      ..fields['petName'] = petname
      ..fields['petBirthday'] = petBirthday
      ..fields['petType'] = petType;

    request.headers.addAll(headers);

    if (profileImage.existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profileImage.path,
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = utf8.decode(responseData);
      return ProfileEditResponseModel.fromJson(jsonDecode(responseString));
    } else {
      return null;
    }
  }
}

final profileRepo = Provider((ref) => ProfileRepository());
