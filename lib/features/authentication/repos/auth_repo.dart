import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

class AuthRepository {
  String? getJwtTokenFromDevice() {
    return SharedPreferencesManager.prefs.getString("jwt");
  }

  Future<void> signIn() async {

  }

  Future<void> signUp() async {
    
  }
  
  Future<void> deleteAccount() async {
    
  }
}

final authRepo = Provider((ref) => AuthRepository());
