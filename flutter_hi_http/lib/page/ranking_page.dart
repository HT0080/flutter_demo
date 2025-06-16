import 'package:flutter/material.dart';
import 'package:flutter_hi_http/http/dao/ranking_dao.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/page/ranking_tab_page.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/hi_tab.dart';
import 'package:flutter_hi_http/widget/navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  ConsumerState<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends ConsumerState<RankingPage>
    with TickerProviderStateMixin {
  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"},
  ];
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
    RankingDao.get("like");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [_buildNavigationBar(), _buildTabView()]),
    );
  }

  _buildNavigationBar() {
    return HNavigationBar(
      child: Container(
        decoration: bottomBoxShadow(ref),
        alignment: Alignment.center,
        child: _tabBar(),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs:
          TABS.map((tab) {
            return Tab(text: tab['name']);
          }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
    );
  }

  _buildTabView() {
    return Flexible(
      child: TabBarView(
        controller: _controller,
        children:
            TABS.map((tab) {
              return RankingTabPage(sort: tab["key"]!);
            }).toList(),
      ),
    );
  }
}
