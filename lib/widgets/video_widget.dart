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
import 'package:swallowing_app/ui/exercise.dart';
import 'package:swallowing_app/widgets/thumbnail_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoWidget extends StatefulWidget {
  final Video video;

  VideoWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
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
      quality: 100),
      parentWidget: 'VideoWidget'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 1,
        child: ClipPath(
          child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ExerciseScreen(video: widget.video)
                      )
                    );
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * Dimens.video_height / Dimens.video_width,
                      color: AppColors.gray,
                      child: (_futureImage != null) ? _futureImage : SizedBox()
                  )
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 6),
                          child: Text(
                            widget.video.name,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: FontFamily.kanit,
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          )
                        )
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          // child: IconButton(
                          //     padding: EdgeInsets.all(0),
                          //     icon: Icon(
                          //       Icons.more_vert,
                          //       size: 24,
                          //       color: Colors.black54,
                          //     ),
                          //     onPressed: () {
                          //
                          //     }
                          // )
                        )
                      )
                    ],
                  )
                )
              ]
          ),
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)
            ),
          ),
        ),
      )
    );
  }
}
