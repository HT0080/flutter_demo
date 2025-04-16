import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color primary;
  final Color background;
  final Color button;
  final Color card;
  final Color text;
  final Color secondaryText;

  const ThemeColors({
    required this.primary,
    required this.background,
    required this.button,
    required this.card,
    required this.text,
    required this.secondaryText,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? primary,
    Color? background,
    Color? button,
    Color? card,
    Color? text,
    Color? secondaryText,
  }) {
    return ThemeColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      button: button ?? this.button,
      card: card ?? this.card,
      text: text ?? this.text,
      secondaryText: secondaryText ?? this.secondaryText,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    covariant ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) return this;
    return ThemeColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      button: Color.lerp(button, other.button, t)!,
      card: Color.lerp(card, other.card, t)!,
      text: Color.lerp(text, other.text, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
    );
  }
}

const lightThemeColors = ThemeColors(
  primary: Color(0xFF2196F3),
  background: Color(0xFFFFFFFF),
  button: Color(0xFF2196F3),
  card: Color(0xFFF5F5F5),
  text: Color(0xFF212121),
  secondaryText: Color(0xFF757575),
);

const darkThemeColors = ThemeColors(
  primary: Color(0xFF673AB7),
  background: Color(0xFF121212),
  button: Color(0xFF673AB7),
  card: Color(0xFF1E1E1E),
  text: Color(0xFFFFFFFF),
  secondaryText: Color(0xFFBDBDBD),
);

const blueThemeColors = ThemeColors(
  primary: Color(0xFF2962FF),
  background: Color(0xFFE3F2FD),
  button: Color(0xFF2962FF),
  card: Color(0xFFBBDEFB),
  text: Color(0xFF0D47A1),
  secondaryText: Color(0xFF1976D2),
);
