import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';
import 'package:mopet/features/authentication/view_models/number_auth_view_model.dart';
import 'package:mopet/features/authentication/views/widgets/number_auth_text_field.dart';
import 'package:mopet/utils/widget_manager.dart';

class NumberAuthScreen extends ConsumerStatefulWidget {
  static const routeName = "number_auth";
  static const routeUrl = "number_auth";

  final bool isAgreeMarketing;
  final String provider;
  final String accessToken;

  const NumberAuthScreen({
    super.key,
    required this.isAgreeMarketing,
    required this.provider,
    required this.accessToken,
  });

  @override
  ConsumerState<NumberAuthScreen> createState() => _NumberAuthScreenState();
}

class _NumberAuthScreenState extends ConsumerState<NumberAuthScreen> {
  final GlobalKey _backButtonKey = GlobalKey();
  final FocusNode _authNumberFocusNode = FocusNode();

  Offset? _backButtonCenter;

  @override
  void dispose() {
    _authNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 중심 좌표 계산을 위한 지연 처리
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    setState(() {
      _backButtonCenter = WidgetManager.getCenter(_backButtonKey, context);
    });
  }

  void _onBackPressed() {
    context.pop();
  }

  void _onBackgroundTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSendButtonTap(String phoneNumber) {
    ref
        .read(numberAuthProvider.notifier)
        .sendSMS(phoneNumber, context, _authNumberFocusNode);
  }

  void _onAuthConfirmButtonTap(String phoneNumber, String authNumber) {
    ref.read(numberAuthProvider.notifier).submitAuthNumber(
        widget.accessToken,
        phoneNumber,
        authNumber,
        widget.isAgreeMarketing,
        widget.provider,
        context);
  }

  void _onCheckPhoneNumber(String phoneNumber) {
    ref.read(numberAuthProvider.notifier).checkValidPhoneNumber(phoneNumber);
  }

  void _onCheckAuthNumber(String authNumber) {
    ref.read(numberAuthProvider.notifier).checkValidAuthNumber(authNumber);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onBackgroundTap,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/commonBtnCheck.png",
                      key: _backButtonKey,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                      color: MopetColor.light07,
                    ),
                    Gaps.v(16),
                    Text(
                      "number_auth_title",
                      style: MopetTextStyle.p70032.copyWith(
                        color: MopetColor.light07,
                      ),
                    ).tr(),
                    Gaps.v(19),
                    NumberAuthTextField(
                      title: "number_auth_write_number",
                      placeholder: "number_auth_write_number_placeholder",
                      actionText: "number_auth_send_button",
                      showWarningTextField:
                          ref.watch(numberAuthProvider).isValidNumber
                              ? false
                              : true,
                      enableActionButton: true,
                      onActionButtonTap: (phoneNumber) =>
                          _onSendButtonTap(phoneNumber),
                      onValueChanged: (phoneNumber) =>
                          _onCheckPhoneNumber(phoneNumber),
                    ),
                    Gaps.v(24),
                    NumberAuthTextField(
                      title: "number_auth_write_auth",
                      placeholder: "number_auth_write_auth_placeholder",
                      actionText: "number_auth_confirm_button",
                      showWarningTextField:
                          ref.watch(numberAuthProvider).isCertifiedAuthNumber
                              ? false
                              : true,
                      enableActionButton:
                          ref.watch(numberAuthProvider).isValidNumber &&
                                  ref
                                      .watch(numberAuthProvider)
                                      .isCertifiedAuthNumber
                              ? true
                              : false,
                      focusNode: _authNumberFocusNode,
                      onActionButtonTap: (authNumber) =>
                          _onAuthConfirmButtonTap(
                              ref.read(numberAuthProvider).phoneNumber,
                              authNumber),
                      onValueChanged: (authNumber) =>
                          _onCheckAuthNumber(authNumber),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: _backButtonCenter != null
                    ? _backButtonCenter!.dx - 20
                    : null,
                top: _backButtonCenter != null
                    ? _backButtonCenter!.dy - 20
                    : null,
                child: GestureDetector(
                  onTap: _onBackPressed,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
