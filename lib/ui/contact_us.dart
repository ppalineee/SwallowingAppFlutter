import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'ติดต่อเรา', visibilityBackIcon: true),
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
          padding: EdgeInsets.all(6),
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Align(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: 300,
                    height: 90,
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
                                'โรงพยาบาลจุฬาลงกรณ์',
                                style: TextStyle(color: AppColors.deepblue, fontSize: 18),
                              ),
                              Text(
                                '+662-649-4000',
                                style: TextStyle(color: AppColors.black, fontSize: 17),
                              ),
                            ]
                        ),
                        GestureDetector(
                          onTap: () async {
                            await UrlLauncher.launch("tel:+6626494000");
                          },
                          child: Icon(
                            Icons.local_phone,
                            color: AppColors.deepblue,
                            size: 30,
                          ),
                        )
                      ],
                    )
                ),
              );
            },
          ),
        ),
      ]
    );
  }
}
