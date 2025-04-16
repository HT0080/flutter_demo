
import 'package:flutter/material.dart';
import 'package:flutter_theme_demo/providers/theme_provider.dart';
import 'package:flutter_theme_demo/themes/theme_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    final colors = ref.watch(themeColorsProvider);
    final currentTheme = ref.watch(themeProvider);
    
    return Card(
      color: colors.card,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text('选择主题', style: TextStyle(
              color: colors.text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 12),
            _buildThemeButton(
              context: context,
              ref: ref,
              mode: AppThemeMode.light,
              label: '浅色主题',
              isSelected: currentTheme == AppThemeMode.light,
            ),
            _buildThemeButton(
              context: context,
              ref: ref,
              mode: AppThemeMode.dark,
              label: '深色主题',
              isSelected: currentTheme == AppThemeMode.dark,
            ),
            _buildThemeButton(
              context: context,
              ref: ref,
              mode: AppThemeMode.blue,
              label: '蓝色主题',
              isSelected: currentTheme == AppThemeMode.blue,
            ),
              _buildThemeButton(
              context: context,
              ref: ref,
              mode: AppThemeMode.system,
              label: '跟随系统',
              isSelected: currentTheme == AppThemeMode.system,
            ),
          ],
        ),
        ),
    );
  }

    Widget _buildThemeButton({
    required BuildContext context,
    required WidgetRef ref,
    required AppThemeMode mode,
    required String label,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        color: _getThemeColor(mode),
        size: 24,
      ),
      title: Text(label, style: TextStyle(
        color: ref.read(themeColorsProvider).text,
      )),
      trailing: isSelected 
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      onTap: () => ref.read(themeProvider.notifier).updateTheme(mode),
    );
  }

  Color _getThemeColor(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.light => lightThemeColors.primary,
      AppThemeMode.dark => darkThemeColors.primary,
      AppThemeMode.blue => blueThemeColors.primary,
      _ =>lightThemeColors.primary
    };
  }
}

