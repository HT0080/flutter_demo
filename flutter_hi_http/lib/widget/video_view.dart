import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hi_http/util/color.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/hi_video_controls.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool autoplay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;

  const VideoView(
    this.url, {
    super.key,
    this.cover,
    this.autoplay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.overlayUI,
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  // 封面
  get _placeholder => FractionallySizedBox(
    widthFactor: 1,
    child: cachedImage("https://www.kaixiangtech.com/img/home_6.6dd766ea.png"),
  );

  get _progeressColors => ChewieProgressColors(
    playedColor: primary,
    handleColor: primary,
    backgroundColor: Colors.grey,
    bufferedColor: primary[50]!,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      allowMuting: true,
      placeholder: _placeholder,
      allowPlaybackSpeedChanging: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      customControls: MaterialControls(
        showLoadingOnInitialize: false,
        showBigPlayIcon: false,
        bottomGradient: blackLinearGradient(),
        overlayUI: widget.overlayUI!,
      ),
      materialProgressColors: _progeressColors,
    );
    // _chewieController?.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _chewieController?.removeListener(_fullScreenListener);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(controller: _chewieController!),
    );
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      // 横屏时强制切回竖屏
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      // 恢复支持所有方向（可选）
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    }
  }
}
