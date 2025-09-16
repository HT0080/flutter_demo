import 'package:flutter/material.dart';
import 'package:flutter_hi_http/core/hi_state.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/dao/home_dao.dart';
import 'package:flutter_hi_http/model/home_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/page/home_tab_page.dart';
import 'package:flutter_hi_http/provider/hi_provider.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/hi_tab.dart';
import 'package:flutter_hi_http/widget/navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class HomePage extends ConsumerStatefulWidget {
  // final ValueChanged<VideoModel>? onJumpToDetail;
  final ValueChanged<int>? onJumpTo;

  const HomePage({super.key, this.onJumpTo});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  TabController? _controller;

  var listener;
  // var tabs = ["推荐", "热门", "追番", "影视", "搞笑", "日常", "综合", "手机游戏", "短片.手书.配音"];
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TabController(length: categoryList.length, vsync: this);
    _controller = TabController(length: 0, vsync: this);
    HiNavigator.getInstance().addListener(
      listener = (current, pre) {
        print('current: ${current.page}');
        print('pre:${pre.page}');
        if (widget == current.page || current.page is HomePage) {
          print('打开了首页 onResume');
        } else if (widget == pre?.page || pre?.page is HomePage) {
          print('首页：onPrause');
        }
      },
    );
    loadData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HiNavigator.getInstance().removeListener(listener);
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
    final themeNotifier = ref.read(rTopProvider.notifier);
    // ref.read(rTopProvider).darModeChange();
    themeNotifier.darkModeChanged();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          HNavigationBar(
            height: 50,
            child: _appBar(),
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
          ),
          Container(
            decoration: bottomBoxShadow(ref),
            padding: EdgeInsets.only(),
            child: _tabBar(),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children:
                  categoryList.map((tab) {
                    return HomeTabPage(
                      categoryName: tab.name,
                      bannerList: tab.name == "推荐" ? bannerList : null,
                    );
                    // return Text("data");
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return HiTab(
      tabs:
          categoryList.map<Tab>((tab) {
            return Tab(
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(tab.name, style: TextStyle(fontSize: 16)),
              ),
            );
          }).toList(),
      controller: _controller!,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
    // TabBar(
    //   controller: _controller!,
    //   isScrollable: true,
    //   dividerHeight: 0,
    //   tabAlignment: TabAlignment.start,
    //   labelColor: Colors.black,
    //   indicator: UnderlineTabIndicator(
    //     borderSide: BorderSide(width: 2.0, color: primary),
    //     insets: EdgeInsets.only(left: 5, right: 5),
    //   ),
    //   tabs:
    //       ,
    // );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get("推荐");
      print(result);
      if (!mounted) return;
      if (result.categoryList != null) {
        _controller = TabController(
          length: result.categoryList!.length,
          vsync: this,
        );
        setState(() {
          categoryList = result.categoryList!;
          bannerList = result.bannerList!;
        });
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                image: AssetImage("images/avatar.png"),
                height: 46,
                width: 46,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.search, color: Colors.grey),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          ),
          Icon(Icons.explore_outlined, color: Colors.grey),
          hiSpace(width: 12),
          GestureDetector(
            onTap: () {
              HiNavigator.getInstance().onJumpTo(RouteStatus.notice);
            },
            child: Icon(Icons.mail_outline, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
