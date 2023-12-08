import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/common/views/mopet_snack_bar.dart';
import 'package:mopet/features/authentication/models/number_auth_model.dart';
import 'package:mopet/features/authentication/repos/auth_repo.dart';
import 'package:mopet/features/authentication/views/register_screen.dart';

class NumberAuthViewModel extends Notifier<NumberAuthModel> {
  @override
  NumberAuthModel build() {
    return NumberAuthModel(
      phoneNumber: "",
      isValidNumber: false,
      isCertifiedAuthNumber: false,
    );
  }

  void checkValidPhoneNumber(String phoneNumber) {
    // 한국 휴대전화 번호 형식을 체크하는 정규 표현식
    // 예: 01038713553
    final regex = RegExp(r'^010\d{7,8}$');

    // 정규 표현식과 전화번호가 일치하는지 확인
    final isValidNumber = regex.hasMatch(phoneNumber);
    state = state.copyWith(
      isValidNumber: isValidNumber,
      phoneNumber: phoneNumber,
    );
  }

  void checkValidAuthNumber(String authNumber) {
    // 4자리 숫자에 해당하는 정규 표현식
    final regex = RegExp(r'^\d{6}$');

    // 정규 표현식과 인증번호가 일치하는지 확인
    final isValidAuthNumber = regex.hasMatch(authNumber);
    state = state.copyWith(
      isCertifiedAuthNumber: isValidAuthNumber,
    );
  }

  Future<void> sendSMS(
      String phoneNumber, BuildContext context, FocusNode focusNode) async {
    final auth = ref.read(authRepo);
    final response = await auth.authenticateAuthNumber(phoneNumber);
    if (response == null) return;
    if (response.isSuccess) {
      final result = response.result;
      if (result == null) return;
      if (!context.mounted) return;
      // 문자 인증 남은 횟수 알림
      MopetSnackBar.show(
        context,
        "number_auth_remain_count_message".tr(
          namedArgs: {
            "count": "${result.remainCount}",
          },
        ),
      );
      // 인증번호 입력으로 포커스 이동
      FocusScope.of(context).requestFocus(focusNode);
    } else {
      if (!context.mounted) return;
      if (response.code == 2001) {
        MopetSnackBar.show(context, "number_auth_error_message_2001".tr());
      } else if (response.code == 2002) {
        MopetSnackBar.show(context, "number_auth_error_message_2002".tr());
      } else if (response.code == 2003) {
        MopetSnackBar.show(context, "number_auth_error_message_2003".tr());
      } else if (response.code == 2005) {
        MopetSnackBar.show(context, "number_auth_error_message_2005".tr());
      } else if (response.code == 2006) {
        MopetSnackBar.show(context, "number_auth_error_message_2006".tr());
      } else {
        MopetSnackBar.show(context, response.message);
      }
    }
  }

  Future<void> submitAuthNumber(
      String accessToken,
      String phoneNumber,
      String authNumber,
      bool isMarketing,
      String provider,
      BuildContext context) async {
    final auth = ref.read(authRepo);
    final response = await auth.checkAuthNumber(phoneNumber, authNumber);
    if (response == null) return;
    if (response.isSuccess) {
      if (!context.mounted) return;
      context.pushNamed(RegisterScreen.routeName, extra: {
        "isMarketing": isMarketing,
        "phoneNumber": phoneNumber,
        "provider": provider,
        "accessToken": accessToken,
      });
    } else {
      if (!context.mounted) return;
      if (response.code == 2011) {
        MopetSnackBar.show(context, "number_auth_error_message_2011".tr());
      } else if (response.code == 2012) {
        MopetSnackBar.show(context, "number_auth_error_message_2012".tr());
      } else if (response.code == 2013) {
        MopetSnackBar.show(context, "number_auth_error_message_2013".tr());
      } else if (response.code == 2014) {
        MopetSnackBar.show(context, "number_auth_error_message_2014".tr());
      } else {
        MopetSnackBar.show(context, response.message);
      }
    }
  }
}

final numberAuthProvider =
    NotifierProvider<NumberAuthViewModel, NumberAuthModel>(
  () => NumberAuthViewModel(),
);
