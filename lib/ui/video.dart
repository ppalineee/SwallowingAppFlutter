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
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _buildMainContent()
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          children: <Widget>[
            _buildVideoPlayer(),
            _buildVideoInfo()
          ]
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return ChewieWidget(
      videoPlayerController: VideoPlayerController.asset(
        'assets/videos/Hi.mp4'
      )
    );
  }

  Widget _buildVideoInfo() {
    return Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
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