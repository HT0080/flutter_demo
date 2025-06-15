import 'package:flutter/material.dart';
import 'package:flutter_hi_http/core/hi_base_tab_state.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/dao/home_dao.dart';
import 'package:flutter_hi_http/model/home_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_hi_http/widget/hi_banner.dart';
import 'package:flutter_hi_http/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo>? bannerList;

  const HomeTabPage({super.key, required this.categoryName, this.bannerList});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends HiBaseTabState<HomeMo, VideoModel, HomeTabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _buildBannerTile() {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: _banner(),
      ),
    );
  }

  Widget _banner() {
    return HiBanner(
      bannerList: widget.bannerList,
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }

  @override
  // TODO: implement contentChild
  get contentChild {
    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        children: [
          if (widget.categoryName == "推荐") _buildBannerTile(),
          ...dataList.map((video) {
            return StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: VideoCard(videoMo: video),
            );
          }),
        ],
      ),
    );
  }

  @override
  Future<HomeMo> getData(int pageIndex) async {
    HomeMo result = await HomeDao.get(
      widget.categoryName,
      pageIndex: pageIndex,
      pageSize: 10,
    );
    return result;
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    return result.videoList;
  }
}
