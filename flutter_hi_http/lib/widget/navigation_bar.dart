import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hi_http/provider/hi_provider.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class HNavigationBar extends ConsumerStatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  HNavigationBar({
    super.key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 46,
    this.child,
  });

  @override
  ConsumerState<HNavigationBar> createState() => _HNavigationBarState();
}

class _HNavigationBarState extends ConsumerState<HNavigationBar> {
  // ignore: prefer_typing_uninitialized_variables
  late StatusStyle _statusStyle;
  late Color _color;
  @override
  Widget build(BuildContext context) {
    var thmemeProvider = ref.watch(rTopProvider);

    if (thmemeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusBarInit(context);
    // 获取状态栏的高度
    var top = MediaQuery.of(context).padding.top;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: _color,
        statusBarIconBrightness:
            _statusStyle == StatusStyle.DARK_CONTENT
                ? Brightness.dark
                : Brightness.light,
        statusBarBrightness:
            _statusStyle == StatusStyle.DARK_CONTENT
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width, // 获取屏幕的宽度
        height: top + widget.height,
        padding: EdgeInsets.only(top: top),
        decoration: BoxDecoration(color: _color),
        child: widget.child ?? null,
      ),
    );
  }

  void _statusBarInit(BuildContext context) {
    //沉浸式状态栏
    changeStatusBar(color: _color, statusStyle: _statusStyle, context: context);
  }
}
