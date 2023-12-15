import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mopet/common/views/mopet_snack_bar.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/authentication/models/register_model.dart';
import 'package:mopet/features/authentication/repos/auth_repo.dart';
import 'package:mopet/features/authentication/view_models/login_view_model.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

class RegisterViewModel extends Notifier<RegisterModel> {
  @override
  RegisterModel build() {
    return RegisterModel(
      username: "",
      isValidUsername: false,
      petname: "",
      isValidPetname: false,
      petBirthday: "",
      isValidPetBirthday: false,
      petType: "",
      isVaildPetType: false,
      enableFinishButton: false,
      profileImage: File(''),
    );
  }

  void reset() {
    state = state.reset();
  }

  void checkValidUsername(String username) {
    var isValidUsername = false;
    if (username.isEmpty || username.length > 7) {
      isValidUsername = false;
    } else {
      isValidUsername = true;
    }

    state = state.copyWith(
      isValidUsername: isValidUsername,
      username: username,
    );
    state = state.copyWith(
      enableFinishButton: isEnableFinishButton(),
    );
  }

  void checkValidPetname(String petname) {
    var isValidPetname = false;
    if (petname.isEmpty || petname.length > 12) {
      isValidPetname = false;
    } else {
      isValidPetname = true;
    }
    state = state.copyWith(
      isValidPetname: isValidPetname,
      petname: petname,
    );
    state = state.copyWith(
      enableFinishButton: isEnableFinishButton(),
    );
  }

  void checkValidPetBirthday(String petBirthday) {
    var isValidPetBirthday = false;
    if (petBirthday.isEmpty || petBirthday.length != 8) {
      isValidPetBirthday = false;
    } else {
      isValidPetBirthday = true;
    }
    state = state.copyWith(
      isValidPetBirthday: isValidPetBirthday,
      petBirthday: petBirthday,
    );
    state = state.copyWith(
      enableFinishButton: isEnableFinishButton(),
    );
  }

  void checkValidPetType(String petType) {
    var isVaildPetType = false;
    if (petType.isEmpty || petType.length > 12) {
      isVaildPetType = false;
    } else {
      isVaildPetType = true;
    }
    state = state.copyWith(
      isVaildPetType: isVaildPetType,
      petType: petType,
    );
    state = state.copyWith(
      enableFinishButton: isEnableFinishButton(),
    );
  }

  bool isEnableFinishButton() {
    if (state.isValidUsername &&
        state.isValidPetname &&
        state.isValidPetBirthday &&
        state.isVaildPetType) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> showAlbum(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      state = state.copyWith(profileImage: file);
    }
  }

  void removeProfileImage() {
    state = state.copyWith(profileImage: File(''));
  }

  Future<void> registerUserAccount(String accessToken, String provider,
      bool marketing, String phone, BuildContext context) async {
    Map<String, dynamic> map = {
      "provider": provider,
      "accessToken": accessToken,
      "termsOfUse": {
        "location": false,
        "marketing": marketing,
        "term": true,
      },
      "phone": phone,
      "image": state.profileImage,
      "nickname": state.username,
      "petName": state.petname,
      "petBirthday": state.petBirthday,
      "petType": state.petType,
    };

    state = state.copyWith(isLoading: true);
    final auth = ref.read(authRepo);
    final response = await auth.registerUserAccount(map);
    state = state.copyWith(isLoading: false);
    if (response == null) return;
    if (response.isSuccess) {
      SharedPreferencesManager.prefs.setString(Keys.nickname, state.username);
      if (!context.mounted) return;
      ref.read(loginProvider.notifier).login(accessToken, provider, context);
    } else {
      if (!context.mounted) return;
      MopetSnackBar.show(context, response.message);
    }
  }
}

final registerProvider = NotifierProvider<RegisterViewModel, RegisterModel>(
  () => RegisterViewModel(),
);
