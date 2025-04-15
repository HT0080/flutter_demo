import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  // token
  static String? get token => _prefs?.getString("token");
  static Future<void> setToken(String value) => _prefs!.setString('token', value);
  static Future<void> removeToken() => _prefs!.remove("token");

// theme mode
static bool get isDarkMode => _prefs?.getBool("darkMode")??false;
static Future<void> setDarkMode(bool value) => _prefs!.setBool("darkMode", value);

// 清空所有缓存
static Future<void> clear() => _prefs!.clear();


}