import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_theme_demo/themes/theme_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, blue, system }

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');
    state =
        savedTheme != null
            ? AppThemeMode.values.firstWhere((e) => e.name == savedTheme)
            : AppThemeMode.system;
  }

  Future<void> updateTheme(AppThemeMode newTheme) async {
    state = newTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', newTheme.name);
  }

  AppThemeMode resolveEffectiveTheme(Brightness platformBrightness) {
    if (state == AppThemeMode.system) {
      // final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      // return brightness == Brightness.dark? AppThemeMode.dark:AppThemeMode.light;
      return platformBrightness == Brightness.dark
          ? AppThemeMode.dark
          : AppThemeMode.light;
    }
    return state;
  }
}

class BrightnessNotifier extends StateNotifier<Brightness>
    with WidgetsBindingObserver {
  BrightnessNotifier()
    : super(WidgetsBinding.instance.platformDispatcher.platformBrightness) {
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangePlatformBrightness() {
    state = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

// 提供者定义
final brightnessProvider =
    StateNotifierProvider<BrightnessNotifier, Brightness>(
      (ref) => BrightnessNotifier(),
    );

final themeColorsProvider = Provider<ThemeColors>((ref) {
  final brightness = ref.watch(brightnessProvider);
  final theme = ref.watch(themeProvider);
  final effectiveTheme =
      theme == AppThemeMode.system
          ? (brightness == Brightness.dark
              ? AppThemeMode.dark
              : AppThemeMode.light)
          : theme;

  return switch (effectiveTheme) {
    AppThemeMode.light => lightThemeColors,
    AppThemeMode.dark => darkThemeColors,
    AppThemeMode.blue => blueThemeColors,
    _ => lightThemeColors,
  };
});
