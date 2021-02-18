import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/models/thumbnail.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/ui/video.dart';
import 'package:swallowing_app/widgets/thumbnail_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;

  VideoPlayerWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  GenThumbnailImage _futureImage;
  String _tempDir;

  @override
  void initState() {
    super.initState();
    getTemporaryDirectory().then((d) => _tempDir = d.path);
    _futureImage = GenThumbnailImage(
        thumbnailRequest: ThumbnailRequest(
            video: widget.video.url,
            thumbnailPath: _tempDir,
            imageFormat: ImageFormat.JPEG,
            maxHeight: 0,
            maxWidth: 0,
            timeMs: 100,
            quality: 100));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.width * 0.65 * Dimens.video_height / Dimens.video_width,
      child: ClipPath(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => VideoScreen(video: widget.video)
                  )
              );
            },
            child: Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * Dimens.video_height / Dimens.video_width,
                    color: AppColors.gray,
                    child: (_futureImage != null) ? _futureImage : SizedBox()
                ),
                Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: AppColors.white,
                      size: 45,
                    )
                )
              ],
            )
        ),
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
          ),
        ),
      )
    );
  }
}
