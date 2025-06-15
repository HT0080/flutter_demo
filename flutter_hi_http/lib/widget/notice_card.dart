import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/home_mo.dart';
import 'package:flutter_hi_http/util/format_util.dart';
import 'package:flutter_hi_http/util/view_util.dart';

class NoticeCard extends StatelessWidget {
  final BannerMo bannerMo;

  const NoticeCard({super.key, required this.bannerMo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(border: borderLine(context)),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_buildIcon(), hiSpace(width: 10), _buildContents()],
        ),
      ),
    );
  }

  _buildIcon() {
    var iconData =
        bannerMo.type == 'video'
            ? Icons.ondemand_video_outlined
            : Icons.card_giftcard;
    return Icon(iconData, size: 30);
  }

  _buildContents() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bannerMo.title, style: TextStyle(fontSize: 16)),
              Text(dateMonthAndDay(bannerMo.createTime)),
            ],
          ),
          hiSpace(height: 5),
          Text(bannerMo.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
