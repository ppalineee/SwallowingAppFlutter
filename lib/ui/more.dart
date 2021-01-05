import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('เพิ่มเติม', false),
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
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        crossAxisCount: 2,
        children: <Widget>[
          _buildIconButton(context, 'แบบทดสอบ', Icons.description, Routes.test),
          _buildIconButton(context, 'ประวัติของฉัน', Icons.account_box, Routes.profile),
          _buildIconButton(context, 'ติดต่อเรา', Icons.info, Routes.contact_us),
          _buildIconButton(context, 'ตั้งค่า', Icons.settings, Routes.setting),
        ],
      )
    );
  }

  Widget _buildIconButton(context, title, icon, route) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.lightgray,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 55,
            )
          ),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
          )
        ],
      )
    );
  }
}