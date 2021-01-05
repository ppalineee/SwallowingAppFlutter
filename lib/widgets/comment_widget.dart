import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:swallowing_app/constants/colors.dart';

class Comment extends StatelessWidget {
  final String creator;
  final String message;
  final String timestamp;

  const Comment(
      this.creator,
      this.message,
      this.timestamp, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 40,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 7, 12, 7),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.verylightgray,
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
                  timestamp,
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