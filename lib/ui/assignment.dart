import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/assignment_status_widget.dart';
import 'package:swallowing_app/widgets/video_widget.dart';

class AssignmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('แบบฝึกหัด', true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Stack(
      children: <Widget>[
        // _handleErrorMessage(),
        _buildMainContent(context),
      ],
    );
  }

  Widget _buildMainContent(context) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20
            ),
            Container(
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
                          child: Text('หัวข้อ', style: TextStyle(fontSize: 17))
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
                            Text('00/00/00', style: TextStyle(fontSize: 17)),
                            Text('00/00/00', style: TextStyle(fontSize: 17)),
                            AssignmentStatusTextWidget(status: 0, fontSize: 17)
                          ],
                        )
                      ]
                  )
                ],
              )
            ),
            SizedBox(
              height: 15
            ),
            Divider(
              thickness: 1.3,
              color: AppColors.gray,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 7, 25, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 55,
                              alignment: Alignment.topCenter,
                              decoration: new BoxDecoration(
                                color: AppColors.deepblue,
                                shape: BoxShape.circle,
                              ),
                              child: Text('1', style: TextStyle(fontSize: 36, color: AppColors.white)),
                            ),
                            SizedBox(
                              width: 15
                            ),
                            Text('ฝึกปฏิบัติตามวิดีโอตัวอย่าง', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue))
                          ]
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      VideoWidget(
                        ratio: 0.55,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 55,
                            alignment: Alignment.topCenter,
                            decoration: new BoxDecoration(
                              color: AppColors.deepblue,
                              shape: BoxShape.circle,
                            ),
                            child: Text('2', style: TextStyle(fontSize: 36, color: AppColors.white)),
                          ),
                          SizedBox(
                              width: 15
                          ),
                          Text('กดปุ่มด้านล่าง เพื่อบันทึกวิดีโอ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.deepblue))
                        ]
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RaisedButton(
                        color: AppColors.deepblue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 1,
                        onPressed: () {

                        },
                        child: Container(
                          width: 60,
                          height: 70,
                          // padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 8.0),
                          child: Icon(
                            Icons.videocam_outlined,
                            color: AppColors.white,
                            size: 60,
                          )
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 55,
                            alignment: Alignment.topCenter,
                            decoration: new BoxDecoration(
                              color: AppColors.deepblue,
                              shape: BoxShape.circle,
                            ),
                            child: Text('3', style: TextStyle(fontSize: 36, color: AppColors.white)),
                          ),
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
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  )
                )
              ),
            )
          ],
        )
    );
  }
}