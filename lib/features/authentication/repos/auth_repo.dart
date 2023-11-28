import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

class AuthRepository {
  Future<void> signIn() async {}

  Future<void> signUp() async {}

  Future<void> deleteAccount() async {}

  String? getJwtTokenFromDevice() {
    return SharedPreferencesManager.prefs.getString("jwt");
  }

  Future<void> setJwtToken(String jwt) async {
    await SharedPreferencesManager.prefs.setString("jwt", jwt);
  }
}

final authRepo = Provider((ref) => AuthRepository());
