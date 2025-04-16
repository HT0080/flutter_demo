import 'package:flutter/material.dart';
import 'package:flutter_theme_demo/providers/theme_provider.dart';
import 'package:flutter_theme_demo/themes/app_theme.dart';
import 'package:flutter_theme_demo/widgets/theme_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeColorsProvider);

    return MaterialApp(
      title: "高级主题示例",
      theme: AppTheme.build(colors),
      home: Scaffold(
        appBar: AppBar(title: const Text('主题定制演示')),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThemeSelector(),
                SizedBox(height: 20),
                _DemoComponents(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoComponents extends ConsumerWidget {
  const _DemoComponents();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeColorsProvider);

    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('示例按钮')),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('这是一个示例卡片', style: TextStyle(color: colors.text)),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '次要文本示例',
          style: TextStyle(color: colors.secondaryText, fontSize: 14),
        ),
      ],
    );
  }
}
