import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/dao/favorite_dao.dart';
import 'package:flutter_hi_http/http/dao/video_detail_dao.dart';
import 'package:flutter_hi_http/model/video_detail_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/appbar.dart';
import 'package:flutter_hi_http/widget/expandable_content.dart';
import 'package:flutter_hi_http/widget/hi_tab.dart';
import 'package:flutter_hi_http/widget/navigation_bar.dart';
import 'package:flutter_hi_http/widget/video_header.dart';
import 'package:flutter_hi_http/widget/video_large_card.dart';
import 'package:flutter_hi_http/widget/video_toolbar.dart';
import 'package:flutter_hi_http/widget/video_view.dart';
import 'package:provider/provider.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  List tabs = ["简介", "评论"];
  VideoDetailMo? videoDetailMo;
  late VideoModel videoModel;
  late List<VideoModel> videoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    changeStatusBar(
      color: Colors.black,
      statusStyle: StatusStyle.LIGHT_CONTENT,
    );
    _controller = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
    _loadDetail();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool removeTop = false;
    double height = 46;
    if (kIsWeb) {
      removeTop = false;
    } else if (Platform.isIOS) {
      removeTop = true;
    } else if (Platform.isAndroid) {
      removeTop = false;
      height = 0;
    }

    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: Platform.isIOS,
        context: context,
        child:
            videoModel.url != null
                ? Column(
                  children: [
                    HNavigationBar(
                      color: Colors.black,
                      statusStyle: StatusStyle.LIGHT_CONTENT,
                      height: height,
                    ),

                    _buildVideoView(),
                    _buildTabNavigation(),
                    Flexible(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          _buildDetailList(),
                          Container(child: Text("期待")),
                        ],
                      ),
                    ),
                  ],
                )
                : Container(),
      ),
    );
  }

  _buildVideoView() {
    var model = videoModel;
    return VideoView(model.url!, cover: model.cover, overlayUI: videoAppBar());
  }

  _buildTabNavigation() {
    var thmemeProvider = context.watch<ThemeProvider>();

    return Material(
      elevation: thmemeProvider.isDark() ? 1 : 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.live_tv_rounded, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs:
          tabs.map<Tab>((name) {
            return Tab(text: name);
          }).toList(),
      controller: _controller,
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [...buildContents(), ..._buildVideoList()],
    );
  }

  buildContents() {
    return [
      VideoHeader(owner: videoModel.owner),
      ExpandableContent(mo: videoModel),
      VideoToolbar(
        detailMo: videoDetailMo,
        videoModel: videoModel,
        onLike: _doLike,
        onUnLike: _onUnLike,
        onFavorite: _onFavorite,
      ),
    ];
  }

  void _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(videoModel.vid);
      print(result);
      setState(() {
        videoDetailMo = result;
        videoModel = result.videoInfo;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void _doLike() {}

  void _onUnLike() {}

  void _onFavorite() async {
    try {
      var result = await FavoriteDao.favorite(
        videoModel.vid,
        !videoDetailMo!.isFavorite,
      );
      print(result);
      videoDetailMo!.isFavorite = !videoDetailMo!.isFavorite;
      if (videoDetailMo!.isFavorite) {
        videoModel.favorite += 1;
      } else {
        videoModel.favorite -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
      showToast("成功");
    } on NeedAuth catch (e) {
      print(e);
    }
  }

  _buildVideoList() {
    return videoList
        .map((VideoModel mo) => VideoLargeCard(videoModel: mo))
        .toList();
  }
}
