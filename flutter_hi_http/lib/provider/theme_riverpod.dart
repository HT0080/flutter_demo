import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hi_http/db/hi_cache.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/hi_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', "Light", "Dark"][index];
}

class ThemeNotifier extends Notifier<ThemeMode> {
  Brightness _platformBrightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  @override
  ThemeMode build() {
    final cacheValue = HiCache.getInstance().get(HiConstants.theme);
    return switch (cacheValue) {
      'Dark' => ThemeMode.dark,
      'System' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  void setTheme(ThemeMode mode) {
    HiCache.getInstance().setString(HiConstants.theme, mode.value);
    state = mode;
  }

  bool isDark() {
    if (state == ThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return state == ThemeMode.dark;
  }

  ThemeMode getThemeMode() {
    String? theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case "Dark":
        state = ThemeMode.dark;
        break;
      case "System":
        state = ThemeMode.system;
        break;
      default:
        state = ThemeMode.light;
        break;
    }
    return state;
  }

  /// 用于监听系统亮暗变化的函数（可结合定时器或 WidgetsBindingObserver）
  void darkModeChanged() {
    final newBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (_platformBrightness != newBrightness) {
      _platformBrightness = newBrightness;
      state = state; // 通知刷新
    }
  }

  ThemeData getThemeData({bool? forceDark}) {
    final isDarkMode = forceDark ?? isDark();
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
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
      indicatorColor: isDarkMode ? primary[50] : white,
      scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : white,
      dividerTheme: DividerThemeData(
        color: isDarkMode ? HiColor.dark_bg : Colors.grey,
      ),
    );
  }
}
