import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mopet/common/widgets/bottom_button.dart';
import 'package:mopet/common/widgets/loading_view.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/features/authentication/views/widgets/register_text_field.dart';
import 'package:mopet/features/profile/view_models/profile_edit_view_model.dart';

class ProfileEditScreen extends ConsumerWidget {
  static const routeName = "profile_edit";
  static const routeUrl = "/profile_edit";

  const ProfileEditScreen({super.key});

  void _onBackgroundPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onImageAddPressed(BuildContext context, WidgetRef ref) async {
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
                    .read(profileEditProvider.notifier)
                    .showAlbum(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text("gallery").tr(),
              onPressed: () {
                Navigator.pop(context);
                ref
                    .read(profileEditProvider.notifier)
                    .showAlbum(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void _onImageRemovePressed(WidgetRef ref) {
    ref.read(profileEditProvider.notifier).removeProfileImage();
  }

  void _onSavePressed(BuildContext context, WidgetRef ref) {
    ref.read(profileEditProvider.notifier).save(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(profileEditProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile_edit_title").tr(),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () => _onBackgroundPressed(context),
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
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gaps.v(24),
                                data?.profileImage.path.isNotEmpty ?? false
                                    ? SizedBox(
                                        width: 72,
                                        height: 72,
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              data!.profileImage,
                                              fit: BoxFit.cover,
                                              width: 72,
                                              height: 72,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    _onImageRemovePressed(ref),
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
                                      )
                                    : GestureDetector(
                                        onTap: () =>
                                            _onImageAddPressed(context, ref),
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
                                      ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_username",
                                  placeholder: "register_username_placeholder",
                                  value: data?.username,
                                  isDisabled: true,
                                  showWarningTextField: false,
                                  onValueChanged: (username) {},
                                ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_petname",
                                  placeholder: "register_petname_placeholder",
                                  value: data?.petname,
                                  showWarningTextField:
                                      data?.isValidPetname ?? true
                                          ? false
                                          : true,
                                  onValueChanged: (petname) => ref
                                      .read(profileEditProvider.notifier)
                                      .checkValidPetname(petname),
                                ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_pet_birthday",
                                  placeholder:
                                      "register_pet_birthday_placeholder",
                                  value: ref
                                      .watch(profileEditProvider)
                                      .value
                                      ?.petBirthday,
                                  textInputType: TextInputType.number,
                                  showWarningTextField:
                                      data?.isValidPetBirthday ?? true
                                          ? false
                                          : true,
                                  onValueChanged: (petBirthday) => ref
                                      .read(profileEditProvider.notifier)
                                      .checkValidPetBirthday(petBirthday),
                                ),
                                Gaps.v(24),
                                RegisterTextField(
                                  title: "register_pet_type",
                                  placeholder: "register_pet_type_placeholder",
                                  value: data?.petType,
                                  showWarningTextField:
                                      data?.isVaildPetType ?? true
                                          ? false
                                          : true,
                                  onValueChanged: (petType) => ref
                                      .read(profileEditProvider.notifier)
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
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomButton(
              text: "save_button",
              onTap: () => _onSavePressed(context, ref),
              enable: data?.enableFinishButton ?? false,
            ),
          ),
          ref.watch(profileEditProvider).isLoading
              ? const LoadingView()
              : Container(),
        ],
      ),
    );
  }
}
