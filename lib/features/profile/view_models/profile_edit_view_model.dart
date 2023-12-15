import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mopet/common/views/mopet_snack_bar.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/profile/models/profile_edit_model.dart';
import 'package:mopet/features/profile/repos/profile_repo.dart';
import 'package:mopet/utils/file_manager.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

class ProfileEditViewModel extends AsyncNotifier<ProfileEditModel> {
  @override
  FutureOr<ProfileEditModel> build() async {
    final response = await ref.read(profileRepo).fetchProfileCheck();
    if (response == null) {
      return ProfileEditModel.empty();
    }
    final result = response.result;
    if (result == null) {
      return ProfileEditModel.empty();
    }

    File imageFile = File('');
    if (result.profileImage == null) {
      imageFile = File('');
    } else {
      imageFile =
          await FileManager.downloadImage(result.profileImage!) ?? File('');
    }

    return ProfileEditModel(
      username: result.nickname,
      petname: result.petName,
      isValidPetname: true,
      petBirthday: result.petBirthday,
      isValidPetBirthday: true,
      petType: result.petType,
      isVaildPetType: true,
      enableFinishButton: true,
      profileImage: imageFile,
    );
  }

  bool isEnableFinishButton(ProfileEditModel value) {
    if (value.isValidPetname &&
        value.isValidPetBirthday &&
        value.isVaildPetType) {
      return true;
    } else {
      return false;
    }
  }

  void checkValidPetname(String petname) {
    final value = state.value;
    if (value == null) return;

    var isValidPetname = false;
    if (petname.isEmpty || petname.length > 12) {
      isValidPetname = false;
    } else {
      isValidPetname = true;
    }

    var newValue = value.copyWith(
      isValidPetname: isValidPetname,
      petname: petname,
    );

    state = AsyncValue.data(
      newValue.copyWith(
        enableFinishButton: isEnableFinishButton(newValue),
      ),
    );
  }

  void checkValidPetBirthday(String petBirthday) {
    final value = state.value;
    if (value == null) return;

    var isValidPetBirthday = false;
    if (petBirthday.isEmpty || petBirthday.length != 8) {
      isValidPetBirthday = false;
    } else {
      isValidPetBirthday = true;
    }

    var newValue = value.copyWith(
      isValidPetBirthday: isValidPetBirthday,
      petBirthday: petBirthday,
    );

    state = AsyncValue.data(
      newValue.copyWith(
        enableFinishButton: isEnableFinishButton(newValue),
      ),
    );
  }

  void checkValidPetType(String petType) {
    final value = state.value;
    if (value == null) return;

    var isVaildPetType = false;
    if (petType.isEmpty || petType.length > 12) {
      isVaildPetType = false;
    } else {
      isVaildPetType = true;
    }

    var newValue = value.copyWith(
      isVaildPetType: isVaildPetType,
      petType: petType,
    );

    state = AsyncValue.data(
      newValue.copyWith(
        enableFinishButton: isEnableFinishButton(newValue),
      ),
    );
  }

  Future<void> showAlbum(ImageSource imageSource) async {
    if (state.value == null) return;
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      state = AsyncValue.data(
        state.value!.copyWith(
          profileImage: file,
        ),
      );
    }
  }

  void removeProfileImage() {
    if (state.value != null) {
      state = AsyncValue.data(
        state.value!.copyWith(
          profileImage: File(''),
        ),
      );
    }
  }

  void save(BuildContext context) async {
    if (state.value == null) return;
    final repo = ref.read(profileRepo);

    state = const AsyncValue.loading();

    final response = await repo.patchProfile(
      uid: SharedPreferencesManager.prefs.getString(Keys.userId) ?? "",
      profileImage: state.value!.profileImage,
      petname: state.value!.petname,
      petBirthday: state.value!.petBirthday,
      petType: state.value!.petType,
    );

    state = AsyncValue.data(state.value!);

    if (response == null) return;
    if (response.isSuccess) {
      print('성공!');
      // TODO: 성공했을때 뒤로가기 처리
    } else {
      if (!context.mounted) return;
      MopetSnackBar.show(context, response.message);
    }

    FileManager.deleteFile(state.value!.profileImage);
  }
}

final profileEditProvider =
    AsyncNotifierProvider<ProfileEditViewModel, ProfileEditModel>(
  () => ProfileEditViewModel(),
);
