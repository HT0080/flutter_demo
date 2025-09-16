import 'package:flutter/material.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:go_router/go_router.dart';

class GoBottomNavigator extends StatefulWidget {
  final Widget child;
  const GoBottomNavigator({super.key, required this.child});

  @override
  State<GoBottomNavigator> createState() => _GoBottomNavigatorState();
}

class _GoBottomNavigatorState extends State<GoBottomNavigator> {
  static final tabs = ["/home", "/ranking", "/favorite", "/profile"];
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  int _locationToTabIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    return tabs
        .indexWhere((tab) => location.path.startsWith(tab))
        .clamp(0, tabs.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _locationToTabIndex(context),
        onTap: (index) => context.go(tabs[index]),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items:
            tabs
                .asMap()
                .entries
                .map(
                  (e) => _bottomItem(
                    ["首页", "排行", "收藏", "我的"][e.key],
                    [
                      Icons.home,
                      Icons.local_fire_department,
                      Icons.favorite,
                      Icons.person,
                    ][e.key],
                    e.key,
                  ),
                )
                .toList(),
      ),
    );
  }

  BottomNavigationBarItem _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}
