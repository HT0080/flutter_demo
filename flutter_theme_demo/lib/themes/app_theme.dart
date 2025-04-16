
import 'package:flutter/material.dart';
import 'package:flutter_theme_demo/themes/theme_colors.dart';

class AppTheme {
static ThemeData build(ThemeColors colors){
  return ThemeData(
      scaffoldBackgroundColor: colors.background,
      primaryColor: colors.primary,
      cardColor: colors.card,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.text),
        bodyMedium: TextStyle(color: colors.secondaryText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.primary,
        foregroundColor: colors.text,
        elevation: 2,
        titleTextStyle: TextStyle(
          color: colors.text,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.button,
          foregroundColor: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: colors.card,
        elevation: 4,
        margin: const EdgeInsets.all(8),
      ),
      extensions: <ThemeExtension<dynamic>>[
        colors,
      ],
  );
}
}