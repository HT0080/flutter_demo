import 'package:flutter/material.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/provider/theme_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/single_child_widget.dart';

// List<SingleChildWidget> topProviders = [
//   // ChangeNotifierProvider(create: (_) => ThemeProvider()),
//   HProvider.ChangeNotifierProvider.value(
//     value: ref.watch(rTopProvider.notifier),
//   ),
// ];

// final rTopProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
//   return ThemeProvider();
// });
final rTopProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
