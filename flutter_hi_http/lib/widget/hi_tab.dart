import 'package:flutter/material.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:provider/provider.dart';

class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final double borderWidth;
  final double insets;
  final double fontSize;
  final Color unselectedLabelColor;

  const HiTab({
    super.key,
    required this.tabs,
    required this.controller,
    this.borderWidth = 2,
    this.insets = 5,
    this.fontSize = 12,
    this.unselectedLabelColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    var thmemeProvider = context.watch<ThemeProvider>();
    Color _unselectedLabelColor =
        thmemeProvider.isDark() ? Colors.white70 : unselectedLabelColor;

    return TabBar(
      controller: controller,
      isScrollable: true,
      dividerHeight: 0,
      tabAlignment: TabAlignment.start,
      labelColor: primary,
      unselectedLabelColor: _unselectedLabelColor,
      labelStyle: TextStyle(fontSize: fontSize),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: primary),
        insets: EdgeInsets.only(left: insets, right: insets),
      ),
      tabs: tabs,
    );
  }
}
