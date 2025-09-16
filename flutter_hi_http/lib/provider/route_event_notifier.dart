import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routeEventNotifierProvider =
    NotifierProvider<RouteEventNotifier, List<RouteEvent>>(
      RouteEventNotifier.new,
    );

class RouteEventNotifier extends Notifier<List<RouteEvent>> {
  @override
  List<RouteEvent> build() {
    // TODO: implement build
    return [];
  }

  void addEvent(RouteEvent event) {
    debugPrint(event.toString());
    state = [...state, event];

    // 保留最近50个事件
    if (state.length > 50) {
      state = state.sublist(state.length - 50);
    }
  }

  void clearEvents() {
    state = [];
  }
}

/// 路由事件类型
enum RouteEventType { redirect, push, pop, replace, gestureStart, gestureEnd }

/// 路由事件模型
class RouteEvent {
  final RouteEventType type;
  final String? from;
  final String? to;
  final DateTime time;

  RouteEvent({required this.type, this.from, this.to, required this.time});
  @override
  String toString() {
    // TODO: implement toString
    return '${type.name}: ${from ?? 'N/A'} → ${to ?? 'N/A'} @ ${time.toIso8601String()}';
  }
}
