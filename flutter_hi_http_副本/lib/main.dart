import 'package:flutter/material.dart';
import 'package:flutter_hi_http/db/hi_cache.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/core/hi_net.dart';
import 'package:flutter_hi_http/http/core/hi_net_adapter.dart';
import 'package:flutter_hi_http/http/dao/login_dao.dart';
import 'package:flutter_hi_http/http/request/notice_request.dart';
import 'package:flutter_hi_http/http/request/test_request.dart';
import 'dart:convert';

import 'package:flutter_hi_http/model/owner.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/navigator/bottom_navigator.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/page/dark_mode_page.dart';
import 'package:flutter_hi_http/page/home_page.dart';
import 'package:flutter_hi_http/page/login_page.dart';
import 'package:flutter_hi_http/page/notice_page.dart';
import 'package:flutter_hi_http/page/registration_page.dart';
import 'package:flutter_hi_http/page/video_detail_page.dart';
import 'package:flutter_hi_http/provider/hi_provider.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/hi_defend.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await HiCache.preInit();

  HiDefend().run(BiliApp());
}

class BiliApp extends ConsumerWidget {
  BiliApp({super.key});

  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  // final BiliRouteInformationParser _routeInformationParser =
  //     BiliRouteInformationParser();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeProvider = rTopProvider;

    return FutureBuilder<HiCache>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        var widget =
            snapshot.connectionState == ConnectionState.done
                ? Router(routerDelegate: _routeDelegate)
                : Scaffold(body: Center(child: CircularProgressIndicator()));
        return Consumer(
          builder: (context, ref, child) {
            final themeProviderState = ref.watch(rTopProvider);
            final themeNotifier = ref.read(rTopProvider.notifier);
            // final themData = themeNotifier.getThemeData();

            // return MaterialApp(
            //   home: widget,
            //   theme: themeNotifier.getThemeData(),
            //   darkTheme: themeNotifier.getThemeData(forceDark: true),
            //   themeMode: themeProviderState,
            // );
            final router = ref.watch(goRouterProvider);
            return MaterialApp.router(
              routerConfig: router,
              theme: themeNotifier.getThemeData(),
              darkTheme: themeNotifier.getThemeData(forceDark: true),
              themeMode: themeProviderState,
            );
          },
        );
      },
    );
  }
}

// 路由代理
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  // 为navigator 设置一个key,必要的时候可以通过navigatorkey.currentState来获取到navigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routesStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {
            videoModel = args!['videoMo'];
          }
          notifyListeners();
        },
      ),
    );
  }
  RouteStatus _routesStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routesStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已经存在，则将该页面和他上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整， 这里要求栈中的只允许有一个同样的页面实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routesStatus == RouteStatus.home) {
      //跳转到首页时，将其它页面进行出栈，因为首页不能回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routesStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (routesStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routesStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    } else if (routesStatus == RouteStatus.notice) {
      page = pageWrap(NoticePage());
    } else if (routesStatus == RouteStatus.darkMode) {
      page = pageWrap(DarkModePage());
    }
    // 管理路由堆栈

    // 重新创建一个数组，否则pages 因引用没有改变路由不会生效
    tempPages = [...tempPages, page];

    // 通知路由变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return PopScope(
      canPop: false,
      child: Navigator(
        key: navigatorKey,
        pages: pages,

        onPopPage: (route, result) {
          if (route.settings is! MaterialPage) {
            // 可选：记录日志或做默认处理
            return route.didPop(result);
          }
          if (route.settings is MaterialPage) {
            // 登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast("请先登录");
                return false;
              }
            }
          }

          // 执行返回操作
          // 在这里控制是否可以返回
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          // 通知路由变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        Navigator.of(context).pop();
        if (_routesStatus == RouteStatus.login) {
        } else {}
      },
    );
  }

  RouteStatus get routesStatus {
    if (_routesStatus != RouteStatus.registration && !hasLogin) {
      return _routesStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routesStatus = RouteStatus.detail;
    } else {
      return _routesStatus;
    }
  }

  get hasLogin => LoginDao.getBoadingPass() != null;
  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

// class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
//   @override
//   Future<BiliRoutePath> parseRouteInformation(
//     RouteInformation routeInformation,
//   ) async {
//     final uri = Uri.parse(routeInformation.location);
//     print('uri:$uri');
//     if (uri.pathSegments.isEmpty) {
//       return BiliRoutePath.home();
//     }
//     return BiliRoutePath.detail();
//   }
// }

/// 定义路由数据，path

class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "/detail";
}

// 创建页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}
