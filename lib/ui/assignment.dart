import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/models/video.dart';
import 'package:swallowing_app/utils/date_format.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/assignment_status_widget.dart';
import 'package:swallowing_app/widgets/camera_widget.dart';
import 'package:swallowing_app/widgets/video_widget.dart';

class AssignmentScreen extends StatefulWidget {
  final Assignment assignment;

  AssignmentScreen({
    Key key,
    @required this.assignment,
  }) : super(key: key);

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('แบบฝึกหัด', true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        // _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20
            ),
            _buildAssignmentInfo(),
            SizedBox(
              height: 15
            ),
            Divider(
              thickness: 1.3,
              color: AppColors.gray,
            ),
            _buildSubmission()
          ],
        )
    );
  }

  Widget _buildAssignmentInfo() {
    return Container(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 105,
                      child: Text('หัวข้อ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue))
                  ),
                  Expanded(
                      child: Text(widget.assignment.title, style: TextStyle(fontSize: 17))
                  )
                ]
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('ได้รับ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue)),
                        Text('กำหนดส่ง', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue)),
                        Text('สถานะ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(DateFormats.changeThaiShortFormat(widget.assignment.timestamp), style: TextStyle(fontSize: 17)),
                      Text(DateFormats.changeThaiShortFormat(widget.assignment.dueDate), style: TextStyle(fontSize: 17)),
                      AssignmentStatusTextWidget(status: widget.assignment.status, fontSize: 17)
                    ],
                  )
                ]
            )
          ],
        )
    );
  }

  Widget _buildSubmission() {
    return Expanded(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: EdgeInsets.fromLTRB(25, 7, 25, 0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  _buildStepOneInfo(),
                  SizedBox(
                    height: 5,
                  ),
                  VideoWidget(
                    video: Video(
                      id: "",
                      name: widget.assignment.videoName,
                      url: widget.assignment.videoUrl,
                      status: "private",
                    )
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  _buildStepTwoInfo(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildCameraBtn(),
                  SizedBox(
                    height: 40,
                  ),
                  _buildStepThreeInfo(),
                  SizedBox(
                    height: 30,
                  )
                ],
              )
          )
      ),
    );
  }

  Widget _buildStepOneInfo() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildStepNo('1'),
          SizedBox(
              width: 15
          ),
          Text('ฝึกปฏิบัติตามวิดีโอตัวอย่าง', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue))
        ]
    );
  }

  Widget _buildStepTwoInfo() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildStepNo('2'),
          SizedBox(
              width: 15
          ),
          Text('กดปุ่มด้านล่าง เพื่อบันทึกวิดีโอ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue))
        ]
    );
  }

  Widget _buildCameraBtn() {
    return RaisedButton(
      color: AppColors.deepblue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      elevation: 1.5,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CameraWidget()
          )
        );
      },
      child: Container(
          width: 60,
          height: 80,
          child: Icon(
            Icons.videocam_outlined,
            color: AppColors.white,
            size: 60,
          )
      ),
    );
  }

  Widget _buildStepThreeInfo() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildStepNo('3'),
          SizedBox(
              width: 15
          ),
          Container(
              width: MediaQuery.of(context).size.width-135,
              child: Text(
                  'เมื่อบันทึกวิดีโอเสร็จสมบูรณ์ สถานะของแบบฝึกหัด "ยังไม่ส่ง" จะเปลี่ยนเป็น "ส่งแล้ว" ให้รอการตรวจสอบจากนักกิจกรรมบำบัด สถานะจึงเปลี่ยนเป็น "ผ่าน" หรือ "ไม่ผ่าน" ในกรณีที่มีสถานะเป็น "ไม่ผ่าน" ให้ทำการบันทึกวิดีโอใหม่อีกครั้งหนึ่ง',
                  style: TextStyle(fontSize: 16, color: AppColors.deepblue)
              )
          ),
        ]
    );
  }

  Widget _buildStepNo(String stepNo) {
    return Container(
      width: 40,
      height: 55,
      alignment: Alignment.topCenter,
      decoration: new BoxDecoration(
        color: AppColors.deepblue,
        shape: BoxShape.circle,
      ),
      child: Text(stepNo, style: TextStyle(fontSize: 36, color: AppColors.white)),
    );
  }
}