import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/video_detail_mo.dart';
import 'package:flutter_hi_http/model/video_model.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/format_util.dart';
import 'package:flutter_hi_http/util/view_util.dart';

class VideoToolbar extends StatelessWidget {
  VideoDetailMo? detailMo;
  final VideoModel videoModel;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  VideoToolbar({
    super.key,
    this.detailMo,
    required this.videoModel,
    this.onLike,
    this.onUnLike,
    this.onCoin,
    this.onFavorite,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(
            Icons.thumb_up_alt_rounded,
            videoModel.like,
            onClick: onLike,
            tint: detailMo == null ? false : detailMo!.isLike,
          ),
          _buildIconText(
            Icons.thumb_down_alt_rounded,
            '不喜欢',
            onClick: onUnLike,
          ),
          _buildIconText(
            Icons.monetization_on,
            videoModel.coin,
            onClick: onCoin,
          ),
          _buildIconText(
            Icons.grade_rounded,
            videoModel.favorite,
            onClick: onFavorite,
            tint: detailMo == null ? false : detailMo!.isFavorite,
          ),
          _buildIconText(
            Icons.share_rounded,
            videoModel.share,
            onClick: onShare,
          ),
        ],
      ),
    );
  }

  _buildIconText(
    IconData iconData,
    var text, {
    VoidCallback? onClick,
    bool tint = false,
  }) {
    if (text is int) {
      text = countFormat(text);
    } else if (text == null) {
      text = '';
    }
    tint = tint ?? false;
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(iconData, color: tint ? primary : Colors.grey, size: 20),
          hiSpace(height: 5),
          Text(text, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
