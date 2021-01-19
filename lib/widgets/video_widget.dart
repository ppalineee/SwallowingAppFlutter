import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/models/video.dart';

class VideoWidget extends StatelessWidget {
  final Video video;

  const VideoWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //         builder: (context) => ArticleScreen(article: article)
        //     )
        // );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 1,
          child: ClipPath(
            child: Column(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * Dimens.video_height / Dimens.video_width,
                      color: AppColors.lightgray,
                      child: Center(
                          child: Text('Video')
                      )
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 6),
                            child: Text(
                              // 'Evaluation and Treatment of Dysphagia, Craig Gluckman, MD | UCLAMDChat',
                              video.name,
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
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.more_vert,
                                  size: 24,
                                  color: Colors.black54,
                                ),
                                onPressed: () {

                                }
                            )
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
      )
    );
  }
}
