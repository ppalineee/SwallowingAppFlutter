import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/chewie_widget.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final Video video;

  VideoScreen({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.video.name, visibilityBackIcon: true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _buildVideoPlayer();
  }

  Widget _buildVideoPlayer() {
    return Container(
        color: AppColors.black,
        child: ChewieWidget(
            videoPlayerController: VideoPlayerController.network(
                widget.video.url
            )
        )
    );
  }
}