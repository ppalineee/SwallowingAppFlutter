import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';

class VideoWidget extends StatelessWidget {
  final double ratio;
  final VoidCallback onPressed;

  const VideoWidget({
    Key key,
    this.ratio = 1,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * ratio,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 1,
        child: ClipPath(
          child: Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * ratio,
                    height: MediaQuery.of(context).size.width * ratio * Dimens.video_height / Dimens.video_width,
                    color: AppColors.lightgray,
                    child: Center(
                        child: Text('Video')
                    )
                ),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      'วิธีการกลืนเบื้องต้น',
                      style: TextStyle(
                        fontFamily: FontFamily.kanit,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
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
