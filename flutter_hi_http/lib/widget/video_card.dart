import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/provider/hi_provider.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/format_util.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCard extends ConsumerWidget {
  final VideoModel videoMo;

  const VideoCard({super.key, required this.videoMo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var thmemeProvider = ref.watch(rTopProvider);

    Color textColor = thmemeProvider.isDark() ? Colors.white70 : Colors.black87;

    return InkWell(
      onTap: () {
        print(videoMo.url);
        HiNavigator.getInstance().onJumpTo(
          RouteStatus.detail,
          args: {"videoMo": videoMo},
        );
      },
      child: SizedBox(
        height: 200,
        child: Card(
          // 取消卡片边距
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_itemImage(context), _infoText(textColor)],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(videoMo.cover, width: size.width / 2 - 8, height: 120),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoMo.view),
                _iconText(Icons.favorite_border, videoMo.favorite),
                _iconText(null, videoMo.duration),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _iconText(IconData? iconData, int count) {
    String views = "";
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(videoMo.duration);
    }
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    );
  }

  _infoText(Color textColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              videoMo.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: textColor),
            ),
            _owner(textColor),
          ],
        ),
      ),
    );
  }

  _owner(Color textColor) {
    var owner = videoMo.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: cachedImage(owner.face, height: 24, width: 24),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: TextStyle(fontSize: 11, color: textColor),
              ),
            ),
          ],
        ),
        Icon(Icons.more_vert_sharp, size: 15, color: Colors.grey),
      ],
    );
  }
}
