import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
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
        _buildVideoInfo(),
        _buildVideoPlayer()
      ]
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      color: AppColors.black,
      child: AspectRatio(
        aspectRatio: Dimens.video_width / Dimens.video_height,
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
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(25, 32, 25, 30),
      child: Text(
        widget.video.name,
        style: TextStyle(
          color: AppColors.deepblue,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      )
    );
  }
}