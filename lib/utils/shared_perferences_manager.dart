import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late final SharedPreferences _prefs;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  static SharedPreferences get prefs {
    if (!_isInitialized) {
      throw Exception("SharedPreferencesManager is not initialized");
    }
    return _prefs;
  }
}