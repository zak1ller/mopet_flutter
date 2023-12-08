import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/common/views/mopet_snack_bar.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/authentication/repos/auth_repo.dart';
import 'package:mopet/features/authentication/views/login_screen.dart';
import 'package:mopet/features/authentication/views/service_access_permission_screen.dart';
import 'package:mopet/features/profile/view_models/settings_view_model.dart';
import 'package:mopet/features/profile/views/settings_screen.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

class LoginViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> loginWithApple(BuildContext context) async {
    final auth = ref.read(authRepo);
    final token = await auth.signInWithApple();
    if (token != null) {
      await SharedPreferencesManager.prefs.setString(
        Keys.provider,
        "apple",
      );
      if (!context.mounted) return;
      login(token, "apple", context);
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    final auth = ref.read(authRepo);
    final token = await auth.signInWithGoogle();
    if (token != null) {
      await SharedPreferencesManager.prefs.setString(
        Keys.provider,
        "google",
      );
      if (!context.mounted) return;
      login(token, "google", context);
    }
  }

  Future<void> loginWithKakao(BuildContext context) async {
    final auth = ref.read(authRepo);
    final token = await auth.signInWithKakao();
    if (token != null) {
      await SharedPreferencesManager.prefs.setString(
        Keys.provider,
        "kakao",
      );
      if (!context.mounted) return;
      login(token.accessToken, "kakao", context);
    }
  }

  Future<void> login(
      String token, String provider, BuildContext context) async {
    final auth = ref.read(authRepo);
    final response = await auth.signIn(token, provider);
    if (response == null) return;
    if (response.isSuccess) {
      // 로그인 성공
      final result = response.result;
      if (result == null) {
        if (!context.mounted) return;
        MopetSnackBar.show(context, response.message);
        return;
      }

      await SharedPreferencesManager.prefs.setString(
        Keys.jwt,
        result.token,
      );
      if (!context.mounted) return;
      updateUser(context);
    } else {
      if (response.code == 3011) {
        // 가입된 정보가 없음
        // 회원가입을 위해 서비스 접근 권한 페이지로 이동
        if (!context.mounted) return;
        context.pushNamed(
          ServiceAccessPermissionScreen.routeName,
          extra: {
            "provider": provider,
            "accessToken": token,
          },
        );
      } else {
        if (!context.mounted) return;
        MopetSnackBar.show(context, response.message);
      }
    }
  }

  Future<void> updateUser(BuildContext context) async {
    final auth = ref.read(authRepo);
    final response = await auth.updateUser();
    print("updateUser: $response");
    if (response == null) return;
    if (response.isSuccess) {
      final result = response.result;
      if (result == null) return;
      print("update user: ${result.nickname}");
      print(result.nickname);
      await SharedPreferencesManager.prefs.setString(
        Keys.nickname,
        result.nickname,
      );
      await SharedPreferencesManager.prefs.setString(
        Keys.mode,
        result.mode,
      );
      await SharedPreferencesManager.prefs.setString(
        Keys.userId,
        result.userId.toString(),
      );
      if (!context.mounted) return;
      checkJwt(context);
    } else {
      if (!context.mounted) return;
      MopetSnackBar.show(context, response.message);
    }
  }

  Future<void> checkJwt(BuildContext context) async {
    final auth = ref.read(authRepo);
    final response = await auth.checkJwt();
    print("checkJwt: $response");
    if (response == null) return;
    if (response.isSuccess) {
      if (response.code == 1000 || response.code == 1001) {
        // 로그인 정보가 교체되었으므로 설정 화면의 데이터를 초기화합니다.
        ref.invalidate(settingsProvider);

        // TODO: 이전 화면으로 돌아가도록 구현
        if (!context.mounted) return;
        context.goNamed(SettingsScreen.routeName);
      } else {
        if (!context.mounted) return;
        MopetSnackBar.show(context, response.message);
      }
    } else {
      if (!context.mounted) return;
      MopetSnackBar.show(context, response.message);
    }
  }

  Future<void> logout(BuildContext context) async {
    await SharedPreferencesManager.prefs.setString(Keys.jwt, "");
    // 로그인 화면으로 이동
    if (!context.mounted) return;
    context.goNamed(LoginScreen.routeName);
  }

  Future<void> deleteAccount(BuildContext context) async {
    final auth = ref.read(authRepo);
    final response = await auth.deleteAccount();
    print("deleteAccount: $response");
    if (response == null) return;
    if (response.isSuccess) {
      await SharedPreferencesManager.prefs.setString(Keys.jwt, "");
      await SharedPreferencesManager.prefs.setString(Keys.userId, "");
      await SharedPreferencesManager.prefs.setString(Keys.provider, "");
      await SharedPreferencesManager.prefs.setString(Keys.mode, "");
      
      if (!context.mounted) return;
      context.goNamed(LoginScreen.routeName);
    } else {
      if (!context.mounted) return;
      MopetSnackBar.show(context, response.message);
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
