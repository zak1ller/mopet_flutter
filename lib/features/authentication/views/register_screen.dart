import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mopet/common/widgets/bottom_button.dart';
import 'package:mopet/common/widgets/loading_view.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';
import 'package:mopet/features/authentication/view_models/register_view_model.dart';
import 'package:mopet/features/authentication/views/widgets/register_text_field.dart';
import 'package:mopet/utils/widget_manager.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const routeName = "register";
  static const routeUrl = "register";

  final bool isAgreeMarketing;
  final String phoneNumber;
  final String provider;
  final String accessToken;

  const RegisterScreen({
    super.key,
    required this.isAgreeMarketing,
    required this.phoneNumber,
    required this.provider,
    required this.accessToken,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey _backButtonKey = GlobalKey();

  Offset? _backButtonCenter;

  @override
  void initState() {
    super.initState();
    // 중심 좌표 계산을 위한 지연 처리
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _afterLayout(_) {
    setState(() {
      _backButtonCenter = WidgetManager.getCenter(_backButtonKey, context);
    });
    // registerProvider 상태 초기화
    ref.read(registerProvider.notifier).reset();
  }

  void _onBackPressed() {
    context.pop();
  }

  void _onBackgroundPressed() {
    FocusScope.of(context).unfocus();
  }

  void _onImageAddPressed() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("profile_image").tr(),
          actions: <Widget>[
            TextButton(
              child: const Text("camera").tr(),
              onPressed: () {
                Navigator.pop(context);
                ref
                    .read(registerProvider.notifier)
                    .showAlbum(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text("gallery").tr(),
              onPressed: () {
                Navigator.pop(context);
                ref
                    .read(registerProvider.notifier)
                    .showAlbum(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void _onImageRemovePressed() {
    ref.read(registerProvider.notifier).removeProfileImage();
  }

  void _onRegisterButtonPressed() {
    ref.read(registerProvider.notifier).registerUserAccount(
          widget.accessToken,
          widget.provider,
          widget.isAgreeMarketing,
          widget.phoneNumber,
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: _onBackgroundPressed,
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
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "register_title",
                                  style: MopetTextStyle.p70032.copyWith(
                                    color: MopetColor.light07,
                                  ),
                                ).tr(),
                                Gaps.v(19),
                                ref
                                        .watch(registerProvider)
                                        .profileImage
                                        .path
                                        .isEmpty
                                    ? GestureDetector(
                                        onTap: _onImageAddPressed,
                                        child: Container(
                                          color: MopetColor.light03,
                                          width: 72,
                                          height: 72,
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/commonIconPlus.png',
                                              color: MopetColor.light07,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 72,
                                        height: 72,
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              ref
                                                  .watch(registerProvider)
                                                  .profileImage,
                                              fit: BoxFit.cover,
                                              width: 72,
                                              height: 72,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: _onImageRemovePressed,
                                                child: Image.asset(
                                                  'assets/images/commonBtnX.png',
                                                  color: MopetColor.light01,
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_username",
                                  placeholder: "register_username_placeholder",
                                  showWarningTextField: ref
                                          .watch(registerProvider)
                                          .isValidUsername
                                      ? false
                                      : true,
                                  onValueChanged: (username) => ref
                                      .read(registerProvider.notifier)
                                      .checkValidUsername(username),
                                ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_petname",
                                  placeholder: "register_petname_placeholder",
                                  showWarningTextField:
                                      ref.watch(registerProvider).isValidPetname
                                          ? false
                                          : true,
                                  onValueChanged: (petname) => ref
                                      .read(registerProvider.notifier)
                                      .checkValidPetname(petname),
                                ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_pet_birthday",
                                  placeholder:
                                      "register_pet_birthday_placeholder",
                                  textInputType: TextInputType.number,
                                  showWarningTextField: ref
                                          .watch(registerProvider)
                                          .isValidPetBirthday
                                      ? false
                                      : true,
                                  onValueChanged: (petBirthday) => ref
                                      .read(registerProvider.notifier)
                                      .checkValidPetBirthday(petBirthday),
                                ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_pet_type",
                                  placeholder: "register_pet_type_placeholder",
                                  showWarningTextField:
                                      ref.watch(registerProvider).isVaildPetType
                                          ? false
                                          : true,
                                  onValueChanged: (petType) => ref
                                      .read(registerProvider.notifier)
                                      .checkValidPetType(petType),
                                ),
                                Gaps.v(56 + 24),
                              ],
                            ),
                          ),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomButton(
              text: "register_complete_button",
              onTap: _onRegisterButtonPressed,
              enable: ref.watch(registerProvider).enableFinishButton,
            ),
          ),
          ref.watch(registerProvider).isLoading
              ? const LoadingView()
              : Container(),
        ],
      ),
    );
  }
}
