import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mopet/constants/base_url.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/authentication/models/auth_check_response_model.dart';
import 'package:mopet/features/authentication/models/delete_account_response_model.dart';
import 'package:mopet/features/authentication/models/jwt_check_response_model.dart';
import 'package:mopet/features/authentication/models/login_reponse_model.dart';
import 'package:http/http.dart' as http;
import 'package:mopet/features/authentication/models/number_auth_response_model.dart';
import 'package:mopet/features/authentication/models/register_response_model.dart';
import 'package:mopet/features/authentication/models/user_update_response_model.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepository {
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String?> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "com.bac.mopet.apple.login",
          redirectUri: Uri.parse(
              "https://imminent-proud-transport.glitch.me/callbacks/sign_in_with_apple"),
        ),
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        rawNonce: rawNonce,
        accessToken: credential.authorizationCode,
      );

      return oauthCredential.idToken;
    } catch (error) {
      return null;
    }
  }

  Future<String?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      return googleAuth.accessToken;
    }
    return null;
  }

  Future<OAuthToken?> signInWithKakao() async {
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        return await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          return await UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          return null;
        }
      }
    } else {
      try {
        return await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        return null;
      }
    }
  }

  Future<LoginResponseModel?> signIn(String token, String provider) async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/v2/login");
    final response = await http.post(uri, body: {
      "provider": provider,
      "accessToken": token,
    });
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<DeleteAccountResponseModel?> deleteAccount() async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/users/profile");
    final headers = await Keys.headers();
    Map<String, dynamic> body = {
      "userId": SharedPreferencesManager.prefs.getString(Keys.userId),
    };

    final response = await http.delete(
      uri,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return DeleteAccountResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<UserUpdateResponseModel?> updateUser() async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/users/update");
    final headers = await Keys.headers();
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return UserUpdateResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<JwtCheckResponseModel?> checkJwt() async {
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/login/check");
    final headers = await Keys.headers();
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return JwtCheckResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<NumberAuthResponseModel?> authenticateAuthNumber(
      String phoneNumber) async {
    Map<String, dynamic> body = {
      "phone": phoneNumber,
    };

    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/auth/phone");
    final response = await http.post(
      uri,
      body: body,
    );

    if (response.statusCode == 200) {
      return NumberAuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<AuthCheckResponseModel?> checkAuthNumber(
      String phoneNumber, String authNumber) async {
    Map<String, dynamic> body = {
      "phone": phoneNumber,
      "checkCode": authNumber,
    };

    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/auth/check");
    final response = await http.post(
      uri,
      body: body,
    );

    if (response.statusCode == 200) {
      return AuthCheckResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel?> registerUserAccount(
      Map<String, dynamic> data) async {
    String termsOfUseJson = json.encode(data['termsOfUse']);

    final String provider = data['provider'];
    final String accessToken = data['accessToken'];
    final String phone = data['phone'];
    final File image = data['image'];
    final String nickname = data['nickname'];
    final String petName = data['petName'];
    final String petBirthday = data['petBirthday'];
    final String petType = data['petType'];

    final headers = await Keys.headers();
    Uri uri = Uri.parse("${BaseUrl.baseUrl}/app/auth/signup");

    // Create multipart request
    var request = http.MultipartRequest("POST", uri)
      ..fields['provider'] = provider
      ..fields['accessToken'] = accessToken
      ..fields['termsOfUse'] = termsOfUseJson
      ..fields['phone'] = phone
      ..fields['nickname'] = nickname
      ..fields['petName'] = petName
      ..fields['petBirthday'] = petBirthday
      ..fields['petType'] = petType;

    request.headers.addAll(headers);

    // Attach the image file if it exists
    if (image.existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));
    }

    // Send the request
    var response = await request.send();
    if (response.statusCode == 200) {
      // Listen for response
      var responseData = await response.stream.toBytes();
      var responseString = utf8.decode(responseData);
      return RegisterResponseModel.fromJson(jsonDecode(responseString));
    } else {
      return null;
    }
  }
}

class MediaType {}

final authRepo = Provider((ref) => AuthRepository());
