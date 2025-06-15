// 创建页面
import 'package:flutter/material.dart';
import 'package:flutter_hi_http/navigator/bottom_navigator.dart';
import 'package:flutter_hi_http/page/dark_mode_page.dart';
import 'package:flutter_hi_http/page/home_page.dart';
import 'package:flutter_hi_http/page/login_page.dart';
import 'package:flutter_hi_http/page/notice_page.dart';
import 'package:flutter_hi_http/page/registration_page.dart';
import 'package:flutter_hi_http/page/video_detail_page.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);

// 创建页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}

// 获取routesStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routesStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routesStatus) {
      return i;
    }
  }
  return -1;
}

/// 定义路由的封装，路由状态
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  unknown,
  notice,
  darkMode,
}

// 获取page对应的路由状态
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else if (page.child is NoticePage) {
    return RouteStatus.notice;
  } else if (page.child is DarkModePage) {
    return RouteStatus.darkMode;
  } else {
    return RouteStatus.unknown;
  }
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routesStatus;
  final Widget page;

  RouteStatusInfo({required this.routesStatus, required this.page});
}

// 监听路由界面跳转
// 感知当前页面是否压后台

class HiNavigator extends _RouteJumpListener {
  RouteJumpListener? _routeJump;

  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;
  // 首页底部tab
  RouteStatusInfo? _bottomTab;
  HiNavigator._();
  static final HiNavigator _instance = HiNavigator._();
  static HiNavigator getInstance() {
    return _instance;
  }

  RouteStatusInfo? getCurrent() {
    return _current;
  }

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(routesStatus: RouteStatus.home, page: page);
    _notify(_bottomTab!);
  }

  // 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  /// 监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  // static HiNavigator get instance => _instance;
  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    if (_routeJump != null) {
      _routeJump!.onJumpTo!(routeStatus, args: args ?? Map());
    }
  }

  /// 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(
      routesStatus: getStatus(currentPages.last),
      page: currentPages.last.child,
    );
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab!;
    }

    print('hi_navigator:current:${current.page}');
    print('hi_navigator:pre:${_current != null ? _current!.page : ""}');

    _listeners.forEach((listener) {
      listener(current, _current!);
    });
    _current = current;
  }
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
