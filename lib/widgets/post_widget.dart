import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/widgets/assignment_status_widget.dart';
import 'package:swallowing_app/widgets/comment_widget.dart';

class PostWidget extends StatefulWidget {
  final Assignment assignment;

  PostWidget({
    Key key,
    @required this.assignment,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isExpanded = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 1,
      child: ClipPath(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width-108,
                            child: Text(
                              widget.assignment.title,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.deepblue),
                            ),
                          ),
                          Text(
                              widget.assignment.timestamp,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)
                          )
                        ]
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushReplacementNamed(Routes.home);
                      },
                      child: Text(
                        'เพิ่มเติม >',
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5 * Dimens.video_height / Dimens.video_width,
                    color: AppColors.lightgray,
                    child: Center(
                        child: Text('Video')
                    )
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AssignmentStatusIconWidget(status: widget.assignment.status),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = (isExpanded == true) ? false : true;
                        });
                      },
                      child: Text(
                        '${widget.assignment.comments.length} ความคิดเห็น',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _buildcommentBtn(),
                isExpanded ? _buildcommentExpansion() : SizedBox.shrink()
              ]
          ),
        ),
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
          ),
        ),
      ),
    );
  }

  Widget _buildcommentBtn() {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColors.gray, width: 0.5),
                bottom: isExpanded ? BorderSide(color: AppColors.gray, width: 0.5) : BorderSide.none
            )
        ),
        child: FlatButton(
            onPressed: () {
              setState(() {
                isExpanded = (isExpanded == true) ? false : true;
              });
            },
            minWidth: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.mode_comment_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'แสดงความคิดเห็น',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)
                  )
                ]
            )
        )
    );
  }

  Widget _buildcommentInputField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {

              },
              child: Icon(
                Icons.camera_alt,
                size: 27,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 7,
            )
          ]
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.deepblue),
                borderRadius: BorderRadius.circular(10)
              ),
              hintText: 'เขียนความคิดเห็น...',
              hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            ),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            minLines: 1,
            maxLines: 8,
          )
        ),
        SizedBox(
          width: 10,
        ),
        Column(
        children: <Widget>[
            GestureDetector(
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(_controller.text),
                      );
                    }
                );
              },
              child: Icon(
                Icons.send,
                size: 27,
                color: AppColors.deepblue,
              ),
            ),
            SizedBox(
              height: 7,
            )
          ]
        ),
      ]
    );
  }

  Widget _buildcommentExpansion() {
    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _buildcommentInputField(),
            SizedBox(
              height: 10,
            ),
            for (var comment in widget.assignment.comments)
              CommentWidget(
                comment.commentator,
                comment.message,
                comment.timestamp
              ),
            SizedBox(
              height: 5,
            ),
          ],
        )
    );
  }
}