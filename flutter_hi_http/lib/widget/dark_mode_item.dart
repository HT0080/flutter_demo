import 'package:flutter/material.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:provider/provider.dart';

class DarkModeItem extends StatelessWidget {
  const DarkModeItem({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var icon =
        themeProvider.isDark()
            ? Icons.nightlight_round
            : Icons.wb_sunny_rounded;

    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.darkMode);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, bottom: 15),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            Text(
              '夜间模式',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 10),
              child: Icon(icon),
            ),
          ],
        ),
      ),
    );
  }
}
