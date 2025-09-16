import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/home_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo>? bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const HiBanner({
    super.key,
    this.bannerList,
    this.bannerHeight = 160,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(height: bannerHeight, child: _banner());
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList![index]);
      },
      itemCount: bannerList?.length ?? 0,
      autoplay: true,
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: right, bottom: 10),
        builder: DotSwiperPaginationBuilder(
          color: Colors.blue,
          size: 6,
          activeSize: 7,
        ),
      ),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo.title);
        _hanleClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(bannerMo.cover, fit: BoxFit.cover),
        ),
      ),
    );
  }

  void _hanleClick(BannerMo bannerMo) {
    if (bannerMo.type == 'video') {
      HiNavigator.getInstance().onJumpTo(
        RouteStatus.detail,
        args: {"videoMo": VideoModel(vid: bannerMo.url)},
      );
    } else {
      print(bannerMo.url);
    }
  }
}
