import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  ChewieWidget({
    @required this.videoPlayerController,
    Key key,
  }) : super(key: key);

  @override
  _ChewieWidgetState createState() => _ChewieWidgetState();
}

class _ChewieWidgetState extends State<ChewieWidget> {
  ChewieController _chewieController;
  Future<void> _future;

  Future<void> initVideoPlayer() async {
    await widget.videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: widget.videoPlayerController.value.aspectRatio,
        autoInitialize: true,
        looping: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _future = initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return widget.videoPlayerController.value.initialized
            ? Chewie(
              controller: _chewieController,
            )
            : Center(
              child: CircularProgressIndicator()
            );
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}