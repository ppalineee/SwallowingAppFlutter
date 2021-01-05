import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('การแจ้งเตือน', true),
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
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Align(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 120
                  ),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: EdgeInsets.symmetric(vertical: 1.5),
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'การบ้านใหม่',
                                  style: TextStyle(color: AppColors.deepblue, fontSize: 17),
                                ),
                                Text(
                                  '00/00/00 00:00',
                                  style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w300, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width-95,
                                  child: Text(
                                    'คุณได้รับการบ้านใหม่',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w300, fontSize: 15),
                                  ),
                                )
                              ]
                          )
                        ],
                      )
                    )
                  ),
              );
            },
          )
        ]
    );
  }
}