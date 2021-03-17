import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/widgets/chewie_widget.dart';
import 'package:swallowing_app/widgets/mirror_widget.dart';
import 'package:video_player/video_player.dart';

class ExerciseScreen extends StatefulWidget {
  final Video video;

  ExerciseScreen({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildVideoPlayer(),
            MirrorWidget(),
          ],
        ),
        _buildBackBtn(),
      ],
    );
  }

  Widget _buildBackBtn() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      )
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
        height: MediaQuery.of(context).size.height/2,
        color: AppColors.black,
        child: ChewieWidget(
            videoPlayerController: VideoPlayerController.network(
                widget.video.url
            )
        )
    );
  }
}