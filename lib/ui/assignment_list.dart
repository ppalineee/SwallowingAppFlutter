import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/text_button_widget.dart';

class AssignmentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('แบบฝึกหัด', false),
      body: _buildBody(context),
      bottomNavigationBar: Navbar(),
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
              height: 12,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButtonWidget(
                buttonText: 'กระดานแบบฝึกหัด',
                buttonColor: AppColors.deepblue,
                textStyle: TextStyle(
                    fontFamily: FontFamily.kanit,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.assignment_board);
                },
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              thickness: 1.3,
              color: AppColors.gray,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('หัวข้อ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text('ได้รับ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text('กำหนดส่ง', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text('สถานะ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1.3,
              color: AppColors.gray,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: 22,
                  itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.assignment);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text('หัวข้อ ${index}', style: TextStyle(fontSize: 15)),
                              ),
                            ),
                            Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('00/00/00', style: TextStyle(fontSize: 14)),
                            ),
                            Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('00/00/00', style: TextStyle(fontSize: 14)),
                            ),
                            Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('สถานะ', style: TextStyle(fontSize: 15)),
                            )
                          ],
                        )
                      );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 0.5,
                      color: AppColors.gray,
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}