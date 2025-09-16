import 'package:flutter/material.dart';
import 'package:flutter_hi_http/core/hi_base_tab_state.dart';
import 'package:flutter_hi_http/http/dao/favorite_dao.dart';
import 'package:flutter_hi_http/model/ranking_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/page/video_detail_page.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/navigation_bar.dart';
import 'package:flutter_hi_http/widget/video_large_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState
    extends HiBaseTabState<RankingMo, VideoModel, FavoritePage> {
  late RouteChangeListener listener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiNavigator.getInstance().addListener(
      listener = (current, pre) {
        if (pre.page is VideoDetailPage && current.page is FavoritePage) {
          loadData();
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [_buildNavigationBar(), Expanded(child: super.build(context))],
    );
  }

  // TODO: implement contentChild
  @override
  get contentChild => ListView.builder(
    padding: EdgeInsets.only(top: 10),
    itemCount: dataList.length,
    controller: scrollController,
    physics: const AlwaysScrollableScrollPhysics(),
    itemBuilder:
        (BuildContext context, int index) =>
            VideoLargeCard(videoModel: dataList[index]),
  );

  @override
  Future<RankingMo> getData(int pageIndex) async {
    RankingMo result = await FavoriteDao.favoriteList(
      pageIndex: pageIndex,
      pageSize: 10,
    );
    return result;
  }

  @override
  List<VideoModel> parseList(RankingMo result) {
    return result.list;
  }

  _buildNavigationBar() {
    return HNavigationBar(
      child: Container(
        decoration: bottomBoxShadow(ref),
        alignment: Alignment.center,
        child: Text('收藏', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
