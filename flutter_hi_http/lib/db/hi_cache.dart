import 'package:shared_preferences/shared_preferences.dart';

/// 缓存管理类

class HiCache {
  SharedPreferences? prefs;
  static HiCache? _instance;

  HiCache._() {
    init();
  }

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  static Future<HiCache> preInit() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance!;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  // 不推荐。类型在运行时，不安全
  T? get<T>(String key) {
    final value = prefs?.get(key);
    if (value == null) {
      return null;
    }
    return value as T?;
  }
}
