import 'package:flutter/material.dart';
import 'package:flutter_hi_http/provider/hi_provider.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class DarkModePage extends ConsumerStatefulWidget {
  const DarkModePage({super.key});

  @override
  ConsumerState<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends ConsumerState<DarkModePage> {
  static const _ITEMS = [
    {"name": "跟随系统", "mode": ThemeMode.system},
    {"name": "开启", "mode": ThemeMode.dark},
    {"name": "关闭", "mode": ThemeMode.light},
  ];
  var _currentTheme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final themeMode = ref.read(rTopProvider);
    _ITEMS.forEach((element) {
      if (element['mode'] == themeMode) {
        _currentTheme = element;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('夜间模式')),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: _ITEMS.length,
      ),
    );
  }

  Widget _item(int index) {
    var theme = _ITEMS[index];
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(child: Text(theme['name'].toString())),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(Icons.done, color: primary),
            ),
          ],
        ),
      ),
    );
  }

  void _switchTheme(int index) {
    var theme = _ITEMS[index];
    final themeNotifier = ref.read(rTopProvider.notifier);
    // ref.read(rTopProvider).setTheme(theme['mode'] as ThemeMode);
    themeNotifier.setTheme(theme['mode'] as ThemeMode);
    setState(() {
      _currentTheme = theme;
    });
  }
}
