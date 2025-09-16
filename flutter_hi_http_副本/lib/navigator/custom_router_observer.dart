import 'package:flutter/material.dart';
import 'package:flutter_hi_http/provider/route_event_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomRouterObserver extends NavigatorObserver {
  final Ref ref;
  CustomRouterObserver(this.ref);

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    _recordRouteEvent(
      RouteEventType.push,
      from: previousRoute?.settings.name,
      to: route.settings.name,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _recordRouteEvent(
      RouteEventType.pop,
      from: route.settings.name,
      to: previousRoute?.settings.name,
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _recordRouteEvent(
      RouteEventType.replace,
      from: oldRoute?.settings.name,
      to: newRoute?.settings.name,
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didStartUserGesture(route, previousRoute);
    // 用户开始手势导航（例如滑动返回）
    ref
        .read(routeEventNotifierProvider.notifier)
        .addEvent(
          RouteEvent(
            type: RouteEventType.gestureStart,
            from: previousRoute?.settings.name,
            to: route.settings.name,
            time: DateTime.now(),
          ),
        );
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    // 用户结束手势导航
    ref
        .read(routeEventNotifierProvider.notifier)
        .addEvent(
          RouteEvent(type: RouteEventType.gestureEnd, time: DateTime.now()),
        );
  }

  void _recordRouteEvent(RouteEventType type, {String? from, String? to}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // // 获取当前路由状态
      final routeState = ref.read(routeEventNotifierProvider.notifier);

      // 添加新事件
      routeState.addEvent(
        RouteEvent(type: type, from: from, to: to, time: DateTime.now()),
      );
    });
  }
}
