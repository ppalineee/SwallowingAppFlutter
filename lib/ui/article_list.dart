import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/dimens.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';

class ArticleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('บทความ', false),
      body: _buildBody(),
      bottomNavigationBar: Navbar(),
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
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 1,
                    child: ClipPath(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: MediaQuery.of(context).size.width * Dimens.video_height / Dimens.video_width / 2,
                              color: AppColors.lightgray,
                              child: Center(child: Text('Picture $index'))
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'วิธีการกลืนเบื้องต้น',
                                    style: TextStyle(
                                      fontFamily: FontFamily.kanit,
                                      fontSize: 17,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'วิธีการกลืนเบื้องต้น',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FontFamily.kanit,
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ]
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
                  );
                },
              ),
            ),
          ],
        )
    );
  }

}
