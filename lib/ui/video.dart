import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      appBar: MyAppBar('วิดีโอ', true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.verylightgray,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _buildMainContent()
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: <Widget>[
        _buildVideoPlayer(),
        _buildVideoInfo()
      ]
    );
  }

  Widget _buildVideoPlayer() {
    return Expanded(
      child: Container(
        color: AppColors.black,
        child: ChewieWidget(
            videoPlayerController: VideoPlayerController.network(
                widget.video.url
            )
        )
      )
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(18, 20, 20, 20),
      child: Text(
        widget.video.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.deepblue,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      )
    );
  }
}