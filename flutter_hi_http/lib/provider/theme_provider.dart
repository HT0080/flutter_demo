import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hi_http/db/hi_cache.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/hi_constants.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', "Light", "Dark"][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  var _platformBrightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  // 系统dark  mode 变化
  void darModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance.platformDispatcher.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      notifyListeners();
    }
  }

  ThemeMode getThemeMode() {
    String? theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }

    return _themeMode == ThemeMode.dark;
  }

  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(HiConstants.theme, themeMode.value);
    notifyListeners();
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // errorColor: isDarkMode ? HiColor.dark_red : HiColor.red,isDarkMode ? HiColor.dark_red : whitev
      primaryColor: isDarkMode ? HiColor.dark_bg : white,
      colorScheme: ColorScheme(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        secondary: isDarkMode ? HiColor.dark_bg : white,
        onSecondary: isDarkMode ? HiColor.dark_bg : white,
        error: isDarkMode ? HiColor.dark_red : HiColor.red,
        onError: isDarkMode ? HiColor.dark_red : HiColor.red,
        surface: isDarkMode ? HiColor.dark_bg : white,
        onSurface: isDarkMode ? white : HiColor.dark_bg,
      ),
      cardTheme: CardThemeData(color: isDarkMode ? Colors.grey : white),
      // tab指示器的Color
      indicatorColor: isDarkMode ? primary[50] : white,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : white,
      dividerTheme: DividerThemeData(
        color: isDarkMode ? HiColor.dark_bg : Colors.grey,
      ),
    );
    return themeData;
  }
}
