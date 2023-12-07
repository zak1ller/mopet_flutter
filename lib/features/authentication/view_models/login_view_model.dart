import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/common/views/mopet_snack_bar.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/authentication/repos/auth_repo.dart';
import 'package:mopet/features/authentication/views/service_access_permission_screen.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

class LoginViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> loginWithApple(BuildContext context) async {
    final auth = ref.read(authRepo);
    final token = await auth.signInWithApple();
    if (token != null) {
      if (!context.mounted) return;
      login(token, "apple", context);
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    final auth = ref.read(authRepo);
    final token = await auth.signInWithGoogle();
    if (token != null) {
      if (!context.mounted) return;
      login(token, "google", context);
    }
  }

  Future<void> loginWithKakao(BuildContext context) async {
    final auth = ref.read(authRepo);
    final token = await auth.signInWithKakao();
    print("token: $token");
    if (token != null) {
      if (!context.mounted) return;
      login(token.accessToken, "kakao", context);
    }
  }

  Future<void> login(
      String token, String provider, BuildContext context) async {
    final auth = ref.read(authRepo);
    final response = await auth.signIn(token, provider);
    print("login: $response");

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
        // 로그인 성공
        print("login success");
      } else {
        if (!context.mounted) return;
        MopetSnackBar.show(context, response.message);
      }
    } else {
      if (!context.mounted) return;
      MopetSnackBar.show(context, response.message);
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
