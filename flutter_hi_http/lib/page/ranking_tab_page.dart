import 'package:flutter/material.dart';
import 'package:flutter_hi_http/core/hi_base_tab_state.dart';
import 'package:flutter_hi_http/http/dao/ranking_dao.dart';
import 'package:flutter_hi_http/model/ranking_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/widget/video_large_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RankingTabPage extends ConsumerStatefulWidget {
  final String sort;

  const RankingTabPage({super.key, required this.sort});

  @override
  ConsumerState<RankingTabPage> createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingMo, VideoModel, RankingTabPage> {
  @override
  // TODO: implement contentChild
  get contentChild => Container(
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      itemCount: dataList.length,
      controller: scrollController,
      itemBuilder:
          (BuildContext context, int index) =>
              VideoLargeCard(videoModel: dataList[index]),
    ),
  );

  @override
  Future<RankingMo> getData(int pageIndex) async {
    RankingMo result = await RankingDao.get(
      widget.sort,
      pageIndex: pageIndex,
      pageSize: 10,
    );
    return result;
  }

  @override
  List<VideoModel> parseList(RankingMo result) {
    return result.list;
  }
}
