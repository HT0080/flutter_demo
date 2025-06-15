import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/page/profile_page.dart';
import 'package:flutter_hi_http/page/video_detail_page.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/format_util.dart';
import 'package:flutter_hi_http/widget/navigation_bar.dart';
import 'package:provider/provider.dart';

Widget cachedImage(String url, {double width = 0, double height = 0}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Container(color: Colors.grey[200]);
    },
    errorWidget: (context, url, error) {
      return Icon(Icons.error);
    },
  );
}

blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
    begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
    end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
    colors: [
      Colors.black54,
      Colors.black45,
      Colors.black38,
      Colors.black26,
      Colors.black12,
      Colors.transparent,
    ],
  );
}

void changeStatusBar({
  color = Colors.white,
  StatusStyle statusStyle = StatusStyle.DARK_CONTENT,
  BuildContext? context,
}) {
  // if (context != null) {
  //   var themeProvider = context.watch<ThemeProvider>();
  //   if (themeProvider.isDark()) {
  //     if (Platform.isIOS) {
  //       statusStyle = StatusStyle.LIGHT_CONTENT;
  //       color = HiColor.dark_bg;
  //     } else if (Platform.isAndroid) {
  //       statusStyle = StatusStyle.LIGHT_CONTENT;
  //       color = HiColor.dark_bg;
  //     }
  //   }
  //   var page = HiNavigator.getInstance().getCurrent()?.page;
  //   if (page is ProfilePage) {
  //     color = Colors.transparent;
  //   } else if (page is VideoDetailPage) {
  //     color = Colors.black;
  //   } else {
  //     color = Colors.transparent;
  //   }
  // }

  // //沉浸式状态栏样式
  // var brightness;
  // if (Platform.isIOS) {
  //   brightness =
  //       statusStyle == StatusStyle.LIGHT_CONTENT
  //           ? Brightness.light
  //           : Brightness.dark;
  // } else if (Platform.isAndroid) {
  //   brightness =
  //       statusStyle == StatusStyle.LIGHT_CONTENT
  //           ? Brightness.light
  //           : Brightness.dark;
  // }

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.transparent,
  //     statusBarBrightness: Brightness.dark,
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  // );
}

// 带文字的小图标
smallIconText(IconData iconData, var text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(iconData, color: Colors.grey, size: 12),
    Text('$text', style: style),
  ];
}

// border线
borderLine(BuildContext context, {bool bottom = true, bool top = false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.green[200]!);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}

// 间隙
SizedBox hiSpace({double height = 1, double width = 1}) {
  return SizedBox(height: height, width: width);
}

// 底部阴影
BoxDecoration? bottomBoxShadow(BuildContext context) {
  var thmemeProvider = context.watch<ThemeProvider>();

  if (thmemeProvider.isDark()) {
    return null;
  }

  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey[100]!,
        offset: Offset(0, 5), // xy轴偏移
        blurRadius: 5.0, // 阴影模糊程度
        spreadRadius: 1, // 阴影扩散程度
      ),
    ],
  );
}
