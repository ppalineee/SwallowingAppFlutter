import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/utils/date_format.dart';

class CommentWidget extends StatelessWidget {
  final String creator;
  final String message;
  final String timestamp;
  final bool isPatient;

  const CommentWidget(
      this.creator,
      this.message,
      this.timestamp,
      this.isPatient, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isPatient ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 40,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 7, 12, 7),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isPatient ? AppColors.lightgreen : AppColors.verylightgray,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  creator,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Text(
                  DateFormats.changeThaiShortFormat(timestamp),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          )
        )
      ]
    );
  }
}