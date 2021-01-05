import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('ประวัติของฉัน', true),
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
    return Stack(
        children: <Widget>[
          Container(
            color: AppColors.lightgray,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Container(
              height: 390,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 60),
                      padding: EdgeInsets.fromLTRB(20, 75, 20, 20),
                      width: MediaQuery.of(context).size.width-80,
                      height: 390,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'HN',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
                              _space(),
                              Text(
                                'ชื่อ',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
                              _space(),
                              Text(
                                'นามสกุล',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
                              _space(),
                              Text(
                                'เพศ',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
                              _space(),
                              Text(
                                'วันเกิด',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
                              _space(),
                              Text(
                                'ผู้ดูแล',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 17, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  'HN',
                                  style: TextStyle(fontSize: 17)),
                              _space(),
                              Text(
                                  'ชื่อ',
                                  style: TextStyle(fontSize: 17)),
                              _space(),
                              Text(
                                  'นามสกุล',
                                  style: TextStyle(fontSize: 17)),
                              _space(),
                              Text(
                                  'เพศ',
                                  style: TextStyle(fontSize: 17)),
                              _space(),
                              Text(
                                  'วันเกิด',
                                  style: TextStyle(fontSize: 17)),
                              _space(),
                              Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width-200,
                                    child: Text(
                                        'ผู้ดูแล',
                                        style: TextStyle(fontSize: 17)),
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.account_circle,
                        color: AppColors.gray,
                        size: 100,
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ]
    );
  }

  Widget _space() {
    return SizedBox(height: 10);
  }
}