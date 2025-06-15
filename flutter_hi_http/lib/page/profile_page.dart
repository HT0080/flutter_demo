import 'package:flutter/material.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/dao/profile_dao.dart';
import 'package:flutter_hi_http/model/profile_mo.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/benefit_card.dart';
import 'package:flutter_hi_http/widget/course_card.dart';
import 'package:flutter_hi_http/widget/dark_mode_item.dart';
import 'package:flutter_hi_http/widget/hi_banner.dart';
import 'package:flutter_hi_http/widget/hi_blur.dart';
import 'package:flutter_hi_http/widget/hi_flexible_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileMo? _profileMo;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[_buildAppBar()];
        },
        body: ListView(
          children: [..._buildContentList()],
          padding: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
              child: cachedImage(
                "https://pics2.baidu.com/feed/f603918fa0ec08fa1f749e41de809e6254fbda5a.jpeg@f_auto?token=ab81c3ba10b58af6d5a85bb19de61d40",
              ),
            ),
            Positioned.fill(child: HiBlur(sigma: 20)),
            Positioned(child: _buildProfileTab(), bottom: 0, left: 0, right: 0),
          ],
        ),
      ),
    );
  }

  void loadData() async {
    try {
      ProfileMo result = await ProfileDao.get();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _buildHead() {
    if (_profileMo == null) return Container();
    return HiFlexibleHeader(
      name: _profileMo!.name,
      face: _profileMo!.face,
      controller: _controller,
    );
  }

  @override
  bool get wantKeepAlive => true;

  _buildContentList() {
    if (_profileMo == null) return [];
    return [
      _buildBanner(),
      CourseCard(courseList: _profileMo?.courseList),
      BenefitCart(benefitList: _profileMo?.benefitList),
      DarkModeItem(),
    ];
  }

  _buildBanner() {
    return HiBanner(
      bannerList: _profileMo?.bannerList,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  _buildProfileTab() {
    if (_profileMo == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(title: '收藏', count: _profileMo!.favorite),
          _buildIconText(title: '点赞', count: _profileMo!.like),
          _buildIconText(title: '浏览', count: _profileMo!.browsing),
          _buildIconText(title: '金币', count: _profileMo!.coin),
          _buildIconText(title: '粉丝', count: _profileMo!.fans),
        ],
      ),
    );
  }

  _buildIconText({String title = "", int count = 0}) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 15, color: Colors.black87)),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
